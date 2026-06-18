library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bissc_clock is
    generic (
        CLK_INITIAL_VALUE : std_ulogic := '1';
        WITH_DEAD_TIME : boolean := true
    );
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
        clk_o : out std_ulogic
    );
end;

architecture rtl of bissc_clock is
    signal clock_timer : unsigned (7 downto 0);
    type clock_state_t is (IDLE, GEN, DEAD);
    signal clock_state : clock_state_t;
    signal rising_counter : unsigned (5 downto 0);
begin

    clock_proc: process (clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i then
                clock_state <= IDLE;
            else
                case clock_state is
                    when IDLE =>
                        done_o <= '0';
                        rising_counter <= n_rising_edges_i;
                        clock_timer <= half_clk_period_i;
                        if go_i then
                            clock_state <= GEN;
                            clk_o <= not CLK_INITIAL_VALUE;
                        else
                            clk_o <= CLK_INITIAL_VALUE;
                        end if;
                    when GEN =>
                        if clock_timer = 0 then
                            clk_o <= not clk_o;
                            clock_timer <= half_clk_period_i;
                            if not clk_o then
                                if rising_counter = 0 then
                                    if WITH_DEAD_TIME then
                                        clock_state <= DEAD;
                                    else
                                        clock_state <= IDLE;
                                        done_o <= '1';
                                    end if;
                                else
                                    rising_counter <= rising_counter - 1;
                                end if;
                            end if;
                        else
                            clock_timer <= clock_timer - 1;
                        end if;
                    when DEAD =>
                        if data_i or go_i then
                            clock_state <= IDLE;
                            done_o <= '1';
                        end if;
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;

end;
