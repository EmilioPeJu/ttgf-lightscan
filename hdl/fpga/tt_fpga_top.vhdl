library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_fpga_top is
    port (
        ui_in : in std_logic_vector(7 downto 0);
        uo_out : out std_logic_vector(7 downto 0);
        uio : inout std_logic_vector(7 downto 0);
        clk : in std_logic;
        rgb : out std_logic_vector(2 downto 0);
        rst_n : in  std_logic
    );
end;

architecture rtl of tt_fpga_top is
    signal uio_in : std_logic_vector(7 downto 0);
    signal uio_out : std_logic_vector(7 downto 0);
    signal uio_oe : std_logic_vector(7 downto 0);
    component SB_IO is
        generic (
            PIN_TYPE : std_logic_vector(5 downto 0)
        );
        port (
            PACKAGE_PIN : inout std_logic;
            OUTPUT_ENABLE : in std_logic;
            D_OUT_0 : in std_logic;
            D_IN_0 : out std_logic
        );
    end component;
begin
    rgb <= "111"; -- turn off RGB LEDs
    sb_io_gen: for i in 0 to 7 generate
        sb_io_inst : SB_IO generic map (
                PIN_TYPE => "101001"
            ) port map (
                PACKAGE_PIN => uio(i),
                OUTPUT_ENABLE => uio_oe(i),
                D_OUT_0 => uio_out(i),
                D_IN_0 => uio_in(i)
            );
    end generate;

    user_project_inst : entity work.tt_um_emiliopeju_lightscan port map (
        ui_in => ui_in,
        uo_out => uo_out,
        uio_in => uio_in,
        uio_out => uio_out,
        uio_oe => uio_oe,
        ena => '1',
        clk => clk,
        rst_n => rst_n
    );
end;
