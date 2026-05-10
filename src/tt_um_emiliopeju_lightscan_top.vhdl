library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_um_emiliopeju_lightscan_top is
    port (
        ui_in  : in  std_ulogic_vector(7 downto 0); -- Dedicated inputs
        uo_out : out std_ulogic_vector(7 downto 0); -- Dedicated outputs

        uio_in : in  std_ulogic_vector(7 downto 0); -- IOs: Input path
        uio_out: out std_ulogic_vector(7 downto 0); -- IOs: Output path
        uio_oe : out std_ulogic_vector(7 downto 0); -- IOs: Enable path (active high: 0=input, 1=output)

        ena    : in  std_ulogic; -- always 1 when the design is powered, so you can ignore it
        clk    : in  std_ulogic; -- clock
        rst_n  : in  std_ulogic  -- reset_n - low to reset
    );
end;

architecture rtl of tt_um_emiliopeju_lightscan_top is
begin
    uo_out <= ui_in;
    uio_out <= (others => '0');
    uio_oe <= (others => '0');
end;
