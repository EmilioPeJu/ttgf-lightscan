library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trigger_generator is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        go_i  : in std_ulogic;
        busy_o : out std_ulogic;
        -- minus one of the trig period in clock cycles
        trig_period_i : in unsigned(31 downto 0);
        -- number of triggers to generate minus one
        ntrig_i : in unsigned(31 downto 0);
        trig_o : out std_ulogic
    );
end;

architecture rtl of trigger_generator is
    signal trig_timer : unsigned(31 downto 0);
    signal trig_count : unsigned(31 downto 0);
    signal running : std_ulogic;
begin
    trig_proc: process (clk_i)
    begin
        if rising_edge(clk_i) then
            trig_o <= '0';
            busy_o <= running or go_i;
            if rst_i then
                trig_timer <= (others => '0');
                trig_count <= (others => '0');
                running <= '0';
            elsif running then
                if trig_timer = 0 then
                    trig_o <= '1';
                    if trig_count = 0 then
                        running <= '0';
                    else
                        trig_count <= trig_count - 1;
                        trig_timer <= trig_period_i;
                    end if;
                else
                    trig_timer <= trig_timer - 1;
                    trig_o <= '0';
                end if;
            elsif go_i then
                running <= '1';
                trig_timer <= trig_period_i;
                trig_count <= ntrig_i;
            end if;
        end if;
    end process;
end;
