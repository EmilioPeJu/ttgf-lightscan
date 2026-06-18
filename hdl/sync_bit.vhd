library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync_bit is
    port (
        clk_i : in std_ulogic;
        bit_i : in std_ulogic;
        bit_o : out std_ulogic
    );
end;


architecture rtl of sync_bit is
    signal bit_meta : std_ulogic := '0';
begin
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            bit_meta <= bit_i;
            bit_o <= bit_meta;
        end if;
    end process;
end;
