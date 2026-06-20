library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_registers is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        cs_i : in std_ulogic;
        sck_i : in std_ulogic;
        rx_i : in std_ulogic;
        tx_o : out std_ulogic;
        trig_i : in std_ulogic;
        override_trig_o : out std_ulogic;
        pos_i : in std_ulogic_vector(50 downto 0);
        pos_valid_i : in std_ulogic;
        error_event_i : in std_ulogic;
        ntrig_o : out unsigned(31 downto 0);
        trig_period_o : out unsigned(31 downto 0);
        width_o : out unsigned(25 downto 0);
        pos_req_o : out std_ulogic;
        acq_start_o : out std_ulogic;
        bissc_half_clk_period_o : out unsigned(7 downto 0);
        bissc_n_rising_edges_o : out unsigned(5 downto 0);
        io_dir_o : out std_ulogic_vector(5 downto 0);
        io_out_o : out std_ulogic_vector(5 downto 0);
        io_in_i : in std_ulogic_vector(5 downto 0)
    );
end;

architecture rtl of spi_registers is
    signal dataout : std_ulogic_vector(31 downto 0);
    signal datain : std_ulogic_vector(39 downto 0);
    signal cs_prev : std_ulogic;
    signal cs_fall : std_ulogic;
    signal sck_prev : std_ulogic;
    signal sck_fall : std_ulogic;
    signal sck_rise : std_ulogic;
    signal sck : std_ulogic;
    signal cs : std_ulogic;
    signal rx : std_ulogic;
    signal bit_counter : unsigned(5 downto 0);
    signal n_err : unsigned(7 downto 0);
    signal n_over : unsigned(7 downto 0);
    signal n_pos : unsigned(15 downto 0);
    signal new_pos : std_ulogic;
    signal io_out : std_ulogic_vector(5 downto 0);
    signal io_dir : std_ulogic_vector(5 downto 0);
    signal io_in : std_ulogic_vector(5 downto 0);
begin
    sync_sck_inst : entity work.sync_bit port map (
        clk_i => clk_i,
        bit_i => sck_i,
        bit_o => sck
    );

    sync_cs_inst : entity work.sync_bit port map (
        clk_i => clk_i,
        bit_i => cs_i,
        bit_o => cs
    );

    sync_rx_inst :  entity work.sync_bit port map (
        clk_i => clk_i,
        bit_i => rx_i,
        bit_o => rx
    );

    cs_fall <= cs_prev and not cs;
    sck_fall <= sck_prev and not sck;
    sck_rise <= not sck_prev and sck;

    count_proc : process (clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i then
                n_err <= (others => '0');
                n_pos <= (others => '0');
            else
                if pos_valid_i then
                    n_pos <= n_pos + 1;
                end if;
                if error_event_i then
                    n_err <= n_err + 1;
                end if;
            end if;
        end if;
    end process;

    process (clk_i)
        variable next_datain : std_ulogic_vector(39 downto 0);
    begin
        if rising_edge(clk_i) then
            cs_prev <= cs;
            sck_prev <= sck;
            pos_req_o <= '0';
            acq_start_o <= '0';
            override_trig_o <= '0';
            if rst_i then
                dataout <= (others => '0');
                new_pos <= '0';
                n_over <= (others => '0');
                ntrig_o <= (others => '0');
                trig_period_o <= (others => '0');
                width_o <= (others => '0');
                bissc_half_clk_period_o <= (others => '0');
                bissc_n_rising_edges_o <= (others => '0');
                io_dir_o <= (others => '0');
                io_out <= (others => '0');
                io_out_o <= (others => '0');
            elsif cs_fall then
                bit_counter <= (others => '0');
            elsif sck_rise then
                bit_counter <= bit_counter + 1;
                next_datain := datain(38 downto 0) & rx;
                datain <= next_datain;
                if bit_counter = 7 then
                    case next_datain(7 downto 0) is
                        when x"00" => -- Magic ID
                            dataout <= x"CAFEA51C";
                        when x"01" => -- Counters
                            dataout <= std_logic_vector(n_over & n_err & n_pos);
                        when x"02" => -- Position
                            dataout <= pos_i(31 downto 0);
                            new_pos <= '0';
                        when x"03" => -- Trigger period
                            dataout <= std_logic_vector(trig_period_o);
                        when x"04" => -- Number of triggers
                            dataout <= std_logic_vector(ntrig_o);
                        when x"05" => -- Pulse width
                            dataout(31 downto 26) <= (others => '0');
                            dataout(25 downto 0) <= std_logic_vector(width_o);
                        when x"06" => -- BISS-C half clock period
                            dataout(31 downto 8) <= (others => '0');
                            dataout(7 downto 0) <=
                                std_logic_vector(bissc_half_clk_period_o);
                        when x"07" => -- BISS-C number of rising edges
                            dataout(31 downto 6) <= (others => '0');
                            dataout(5 downto 0) <=
                                std_logic_vector(bissc_n_rising_edges_o);
                        when x"08" => -- Position (high bits)
                            dataout(31 downto 0) <= pos_i(50 downto 19);
                        when x"0a" => -- Synchronized Inputs
                            dataout(31 downto 6) <= (others => '0');
                            dataout(5 downto 0) <= io_in;
                        when x"0b" => -- Current Inputs
                            dataout(31 downto 6) <= (others => '0');
                            dataout(5 downto 0) <= io_in_i;
                        when others =>
                            dataout <= (others => '0'); -- Default case
                    end case;
                elsif bit_counter = 39 then
                    case next_datain(39 downto 32) is
                        when x"83" => -- Trigger period
                            trig_period_o <= unsigned(next_datain(31 downto 0));
                        when x"84" => -- Number of triggers
                            ntrig_o <= unsigned(next_datain(31 downto 0));
                        when x"85" => -- Pulse width
                            width_o <= unsigned(next_datain(25 downto 0));
                        when x"86" => -- BISS-C half clock period
                            bissc_half_clk_period_o <= unsigned(next_datain(7 downto 0));
                        when x"87" => -- BISS-C number of rising edges
                            bissc_n_rising_edges_o <= unsigned(next_datain(5 downto 0));
                        when x"89" =>
                            -- Request position
                            pos_req_o <= next_datain(0);
                             -- Start acquisition
                            acq_start_o <= next_datain(1);
                            -- Manual trigger
                            override_trig_o <= next_datain(2);
                        when x"8a" => -- Synchronized Outputs
                            io_out <= next_datain(5  downto 0);
                            io_dir <= next_datain(13 downto 8);
                        when x"8b" => -- Override Outputs
                            io_out_o <= next_datain(5  downto 0);
                            io_dir_o <= next_datain(13 downto 8);
                        when others =>
                        null;
                    end case;
                end if;
            elsif sck_fall then
                dataout <= dataout(30 downto 0) & '0';
                tx_o <= dataout(31);
            end if;
            if pos_valid_i then
                new_pos <= '1';
                if new_pos then
                    n_over <= n_over + 1;
                end if;
            end if;
            if trig_i then
                io_out_o <= io_out;
                io_dir_o <= io_dir;
                io_in <= io_in_i;
            end if;
        end if;
    end process;
end;
