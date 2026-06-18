library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bissc_request is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        req_period_i : in unsigned(24 downto 0);
        req_o : out std_ulogic
    );
end;

architecture rtl of bissc_request is
    -- Make sure the first request is sent a little after reset to allow
    -- initialization.
    constant REQ_TIMER_INIT : unsigned (24 downto 0) := to_unsigned(4, 25);
    signal req_timer : unsigned (24 downto 0) := REQ_TIMER_INIT;
begin
    req_timer_proc: process (clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' or req_period_i = to_unsigned(0, req_period_i'length) then
                req_timer <= REQ_TIMER_INIT;
                req_o <= '0';
            elsif req_timer = 0 then
                req_timer <= req_period_i;
                req_o <= '1';
            else
                req_timer <= req_timer - 1;
                req_o <= '0';
            end if;
        end if;
    end process;
end;
