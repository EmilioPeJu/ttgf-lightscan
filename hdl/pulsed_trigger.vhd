library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulsed_trigger is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        go_i  : in std_ulogic;
        busy_o : out std_ulogic;
        -- minus one of the trig period in clock cycles
        trig_period_i : in unsigned(31 downto 0);
        -- number of triggers to generate minus one
        ntrig_i : in unsigned(31 downto 0);
        -- pulse width minus two in clock cycles
        width_i : in unsigned(25 downto 0);
        trig_o : out std_ulogic;
        pulse_o : out std_ulogic
    );
end;

architecture rtl of pulsed_trigger is
    signal trig : std_ulogic;
    signal busy : std_ulogic;
begin
    busy_o <= busy or pulse_o;
    trig_o <= trig;

    pulse_stretch_inst : entity work.pulse_stretch port map (
        clk_i => clk_i,
        rst_i => rst_i,
        width_i => width_i,
        trig_i => trig,
        pulse_o => pulse_o
    );

    trig_gen_inst : entity work.trigger_generator port map (
        clk_i => clk_i,
        rst_i => rst_i,
        go_i => go_i,
        busy_o => busy,
        trig_period_i => trig_period_i,
        ntrig_i => ntrig_i,
        trig_o => trig
    );
end;
