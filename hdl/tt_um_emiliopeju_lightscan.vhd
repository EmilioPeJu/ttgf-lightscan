library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_um_emiliopeju_lightscan is
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

architecture rtl of tt_um_emiliopeju_lightscan is
    signal pos : std_ulogic_vector(50 downto 0);
    signal pos_valid : std_ulogic;
    signal pos_err : std_ulogic;
    signal pos_req : std_ulogic;
    signal rst : std_ulogic;
    signal biss_data_sync : std_ulogic;
    signal biss_data_sync_deglitched : std_ulogic;
    signal bissc_go : std_ulogic;
    signal acq_start : std_ulogic;
    signal trig : std_ulogic;
    signal trig_period : unsigned(31 downto 0);
    signal ntrig : unsigned(31 downto 0);
    signal width : unsigned(25 downto 0);
    signal bissc_half_clk_period : unsigned(7 downto 0);
    signal bissc_n_rising_edges : unsigned(5 downto 0);
begin
    uio_oe <= "00000001";
    rst <= not rst_n;
    bissc_go <= pos_req or trig;

    reg_inst: entity work.spi_registers port map (
        clk_i => clk,
        rst_i => rst,
        cs_i => ui_in(0),
        sck_i => ui_in(1),
        rx_i => ui_in(2),
        tx_o => uo_out(3),
        pos_i => pos(31 downto 0),
        pos_valid_i => pos_valid,
        error_event_i => pos_err,
        ntrig_o => ntrig,
        trig_period_o => trig_period,
        width_o => width,
        pos_req_o => pos_req,
        acq_start_o => acq_start,
        bissc_half_clk_period_o => bissc_half_clk_period,
        bissc_n_rising_edges_o => bissc_n_rising_edges
    );

    pulsed_trigger_inst: entity work.pulsed_trigger port map (
        clk_i => clk,
        rst_i => rst,
        go_i => acq_start,
        busy_o => uo_out(0),
        trig_period_i => trig_period,
        ntrig_i => ntrig,
        width_i => width,
        trig_o => trig,
        pulse_o => uo_out(1)
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
        go_i => bissc_go,
        half_clk_period_i => bissc_half_clk_period,
        n_rising_edges_i => bissc_n_rising_edges,
        pos_o => pos,
        valid_o => pos_valid,
        err_o => pos_err,
        clk_o => uio_out(0),
        data_i => biss_data_sync
    );
end;
