library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_stretch is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        -- pulse width minus two in clock cycles
        width_i : in unsigned(25 downto 0);
        trig_i : in std_ulogic;
        pulse_o : out std_ulogic
    );
end;

architecture rtl of pulse_stretch is
    signal pulse_timer : unsigned(25 downto 0);
    signal pulse : std_ulogic;
begin
    pulse_o <= pulse or trig_i;

    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i then
                pulse_timer <= (others => '0');
                pulse <= '0';
            elsif trig_i then
                pulse_timer <= width_i;
                pulse <= '1';
            elsif pulse_timer /= 0 then
                pulse_timer <= pulse_timer - 1;
                pulse <= '1';
            else
                pulse <= '0';
            end if;
        end if;
    end process;
end;
