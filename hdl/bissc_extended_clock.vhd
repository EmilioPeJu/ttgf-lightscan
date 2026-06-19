library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bissc_extended_clock is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        go_i : in std_ulogic;
        done_o : out std_ulogic;
        -- number of bits minus one
        n_rising_edges_i : in unsigned(5 downto 0);
        -- half clock period minus one
        half_clk_period_i : in unsigned(7 downto 0);
        data_i : in std_ulogic;
        samp_o : out std_ulogic;
        -- aligned data
        data_o : out std_ulogic;
        clk_o : out std_ulogic
    );
end;

architecture rtl of bissc_extended_clock is
    signal nbits: unsigned(n_rising_edges_i'range);
    signal samp_clk: std_ulogic;
    signal samp_clk_dly: std_ulogic;
    signal samp_clk_rise: std_ulogic;
    signal go2: std_ulogic;
    type state_type is (IDLE, WAIT_ACK, WAIT_DONE);
    signal state: state_type := IDLE;
    signal data_dly : std_ulogic;
    signal data_dly2 : std_ulogic;
    signal busy1: std_ulogic;
    signal busy2: std_ulogic;
begin
    samp_o <= samp_clk_rise;
    nbits <= n_rising_edges_i - 2;

    bissc_clock_inst: entity work.bissc_clock generic map (
        CLK_INITIAL_VALUE => '1',
        WITH_DEAD_TIME => true
    ) port map (
        clk_i => clk_i,
        rst_i => rst_i,
        go_i => go_i,
        busy_o => busy1,
        n_rising_edges_i => n_rising_edges_i,
        half_clk_period_i => half_clk_period_i,
        data_i => data_i,
        clk_o => clk_o
    );

    bissc_samp_clock_inst: entity work.bissc_clock generic map (
        CLK_INITIAL_VALUE => '1',
        WITH_DEAD_TIME => false
    ) port map (
        clk_i => clk_i,
        rst_i => rst_i,
        go_i => go2,
        busy_o => busy2,
        n_rising_edges_i => nbits,
        half_clk_period_i => half_clk_period_i,
        data_i => data_i,
        clk_o => samp_clk
    );

    samp_clk_rise <= samp_clk and not samp_clk_dly;
    data_o <= data_dly2;

    process (clk_i)
    begin
        if rising_edge(clk_i) then
            samp_clk_dly <= samp_clk;
            data_dly <= data_i;
            data_dly2 <= data_dly;
            go2 <= '0';
            if rst_i then
                state <= IDLE;
            else
                done_o <= '0';
                case state is
                    when IDLE =>
                        if go_i then
                            state <= WAIT_ACK;
                        end if;
                    when WAIT_ACK =>
                        if not data_i then
                            go2 <= '1';
                            state <= WAIT_DONE;
                        elsif go_i then
                            state <= WAIT_DONE;
                        end if;
                    when WAIT_DONE =>
                        if not busy1 and not busy2 then
                            state <= IDLE;
                            done_o <= '1';
                        end if;
                    when others =>
                        null;
                    end case;
            end if;
        end if;
    end process;
end;
