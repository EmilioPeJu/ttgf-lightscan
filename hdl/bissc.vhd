library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bissc is
    Port(
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        go_i  : in std_ulogic;
        -- half clock period minus one
        half_clk_period_i : in unsigned(7 downto 0);
        n_rising_edges_i : in unsigned(5 downto 0);
        pos_o : out std_ulogic_vector(50 downto 0);
        valid_o : out std_ulogic;
        err_o : out std_ulogic;
        clk_o : out std_ulogic;
        data_i : in std_ulogic
    );
end;

architecture arch of bissc is
    signal clock_done : std_ulogic;
    signal data : std_ulogic;
    signal samp : std_ulogic;
begin
    bissc_extended_clock_inst : entity work.bissc_extended_clock port map (
        clk_i => clk_i,
        rst_i => rst_i,
        go_i => go_i,
        done_o => clock_done,
        n_rising_edges_i => n_rising_edges_i,
        half_clk_period_i => half_clk_period_i,
        data_i => data_i,
        samp_o => samp,
        data_o => data,
        clk_o => clk_o
    );

    bissc_capture_inst : entity work.bissc_capture port map (
        clk_i => clk_i,
        rst_i => rst_i,
        go_i => go_i,
        done_i => clock_done,
        samp_i => samp,
        data_i => data,
        pos_o => pos_o,
        valid_o => valid_o,
        err_o => err_o
    );
end;
