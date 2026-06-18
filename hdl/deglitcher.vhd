library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deglitcher is
    generic (
        WIDTH : positive := 3
    );
    port (
        clk_i : in std_ulogic;
        bit_i : in std_ulogic;
        bit_o : out std_ulogic
    );
end;

architecture rtl of deglitcher is
    signal bit_shift : std_ulogic_vector(WIDTH-1 downto 0);
    constant ZEROS : std_ulogic_vector(WIDTH-1 downto 0) := (others => '0');
    constant ALL_ONES : std_ulogic_vector(WIDTH-1 downto 0) := (others => '1');
begin
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            bit_shift <= bit_shift(1 downto 0) & bit_i;
            if bit_shift = ALL_ONES then
                bit_o <= '1';
            elsif bit_shift = ZEROS then
                bit_o <= '0';
            end if;
        end if;
    end process;
end;
