library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_um_emiliopeju_lightscan_top is
    port (
        clk    : in  std_ulogic; -- clock
        ui_in  : in  std_ulogic_vector(7 downto 0); -- Dedicated inputs
        uo_out : out std_ulogic_vector(7 downto 0); -- Dedicated outputs
        uio_in : in  std_ulogic_vector(7 downto 0); -- IOs: Input path
        uio_out: out std_ulogic_vector(7 downto 0); -- IOs: Output path
        uio_oe : out std_ulogic_vector(7 downto 0); -- IOs: Enable path (active high: 0=input, 1=output)

        ena    : in  std_ulogic; -- always 1 when the design is powered, so you can ignore it
        rst_n  : in  std_ulogic  -- reset_n - low to reset
    );
end;

architecture rtl of tt_um_emiliopeju_lightscan_top is
    signal pos : std_logic_vector(50 downto 0);
    signal pos_valid : std_logic;
    signal pos_err : std_logic;
    signal rst : std_logic;
    signal latched_pos : std_logic_vector(31 downto 0);
    signal biss_data_sync : std_logic;
    signal biss_data_sync_deglitched : std_logic;
begin
    uio_oe <= "00000001";
    rst <= not rst_n;

    process (clk)
    begin
        if rising_edge(clk) then
            if pos_valid then
                latched_pos <= pos_err & pos(30 downto 0);
            end if;
        end if;
    end process;

    reg_inst: entity work.spi_registers port map (
        clk_i => clk,
        rst_i => rst,
        cs_i => ui_in(0),
        sck_i => ui_in(1),
        rx_i => ui_in(2),
        tx_o => uo_out(3),
        pos_i => latched_pos
    );

    sync_biss_data_inst: entity work.sync_bit port map (
        clk_i => clk,
        bit_i => uio_in(1),
        bit_o => biss_data_sync
    );

    deglitcher_inst: entity work.deglitcher port map (
        clk_i => clk,
        bit_i => biss_data_sync,
        bit_o => biss_data_sync_deglitched
    );

    bissc_inst: entity work.bissc port map (
        clk_i => clk,
        rst_i => rst,
        req_period_i => to_unsigned(1200000, 25),
        half_clk_period_i => to_unsigned(5, 8),
        n_rising_edges_i => to_unsigned(26, 6),
        pos_o => pos,
        valid_o => pos_valid,
        err_o => pos_err,
        clk_o => uio_out(0),
        data_i => biss_data_sync
    );
end;
