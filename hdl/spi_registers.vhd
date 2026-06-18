library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_registers is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        cs_i : in std_ulogic;
        sck_i : in std_ulogic;
        rx_i : in std_ulogic;
        tx_o : out std_ulogic;
        pos_i : in std_ulogic_vector(31 downto 0)
    );
end;

architecture rtl of spi_registers is
    signal dataout : std_ulogic_vector(31 downto 0);
    signal datain : std_ulogic_vector(39 downto 0);
    signal cs_prev : std_ulogic;
    signal cs_fall : std_ulogic;
    signal sck_prev : std_ulogic;
    signal sck_fall : std_ulogic;
    signal sck_rise : std_ulogic;
    signal sck : std_ulogic;
    signal cs : std_ulogic;
    signal rx : std_ulogic;
    signal bit_counter : unsigned(5 downto 0);
begin
    sync_sck_inst : entity work.sync_bit port map (
        clk_i => clk_i,
        bit_i => sck_i,
        bit_o => sck
    );

    sync_cs_inst : entity work.sync_bit port map (
        clk_i => clk_i,
        bit_i => cs_i,
        bit_o => cs
    );

    sync_rx_inst :  entity work.sync_bit port map (
        clk_i => clk_i,
        bit_i => rx_i,
        bit_o => rx
    );

    cs_fall <= cs_prev and not cs;
    sck_fall <= sck_prev and not sck;
    sck_rise <= not sck_prev and sck;

    process (clk_i)
        variable next_datain : std_ulogic_vector(39 downto 0);
    begin
        if rising_edge(clk_i) then
            cs_prev <= cs;
            sck_prev <= sck;
            if rst_i then
                dataout <= (others => '0');
            elsif cs_fall then
                bit_counter <= (others => '0');
            elsif sck_rise then
                bit_counter <= bit_counter + 1;
                next_datain := datain(38 downto 0) & rx;
                datain <= next_datain;
                if bit_counter = 7 then
                    case next_datain(7 downto 0) is
                        when "00000001" => -- Test Identifier
                            dataout <= x"42424242";
                        when "00000010" => -- Command 2
                            dataout <= pos_i;
                        when others =>
                            dataout <= (others => '0'); -- Default case
                    end case;
                elsif bit_counter = 39 then
                    case next_datain(39 downto 32) is
                        -- Placeholder to handle writes
                        when others =>
                            null;
                    end case;
                end if;
            elsif sck_fall then
                dataout <= dataout(30 downto 0) & '0';
                tx_o <= dataout(31);
            end if;
        end if;
    end process;
end;
