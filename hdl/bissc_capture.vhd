library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bissc_capture is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        go_i : in std_ulogic;
        samp_i : in std_ulogic;
        data_i : in std_ulogic;
        done_i : in std_ulogic;
        pos_o : out std_ulogic_vector(50 downto 0);
        valid_o : out std_ulogic;
        err_o : out std_ulogic
    );
end;

architecture rtl of bissc_capture is
    type state_type is (IDLE, WAIT_START, CAPTURE_POS);
    signal state : state_type;
    signal initial_bits : std_ulogic_vector(2 downto 0);
    signal crc : std_ulogic_vector(5 downto 0);
    signal shift_pos : std_ulogic_vector(58 downto 0);
begin
    process (clk_i)
        variable next_initial_bits : std_ulogic_vector(2 downto 0);
    begin
        if rising_edge(clk_i) then
            valid_o <= '0';
            err_o <= '0';
            if rst_i then
                state <= IDLE;
            else
                case state is
                    when IDLE =>
                        initial_bits <= (others => '0');
                        crc <= (others => '0');
                        shift_pos <= (others => '0');
                        if go_i then
                            state <= WAIT_START;
                        end if;
                    when WAIT_START =>
                        if done_i then
                            state <= IDLE;
                            err_o <= '1';
                        end if;
                        if samp_i then
                            next_initial_bits := initial_bits(1 downto 0) & data_i;
                            initial_bits <= next_initial_bits;
                            if next_initial_bits = "010" then
                                state <= CAPTURE_POS;
                            end if;
                        end if;
                    when CAPTURE_POS =>
                        if samp_i then
                            shift_pos <= shift_pos(57 downto 0) & data_i;
                            crc(5 downto 2) <= crc(4 downto 1);
                            crc(1) <= crc(0) xor crc(5);
                            crc(0) <= data_i xor crc(5);
                        end if;
                        if done_i then
                            state <= IDLE;
                            valid_o <= '1';
                            pos_o <= shift_pos(58 downto 8);
                            if crc /= "111111" or shift_pos(7) = '0' then
                                err_o <= '1';
                            end if;
                        end if;
                end case;
            end if;
        end if;
    end process;
end;
