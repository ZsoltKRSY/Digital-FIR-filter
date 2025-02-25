----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2024 12:31:02 PM
-- Design Name: 
-- Module Name: divizor_clk - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divizor_clk is
    Generic(
        generated_freq : INTEGER := 50_000_000
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           new_clk : out STD_LOGIC
    );
end divizor_clk;

architecture Behavioral of divizor_clk is

signal counter: integer := 0;
signal counter_max: integer := 1_000_000_000 / generated_freq / 20 - 1;
signal clk_aux: std_logic := '0';

begin

new_clk <= clk_aux;

process(clk, rst)
begin

if rst = '1' then
    counter <= 0;
    clk_aux <= '0';
elsif rising_edge(clk) then
    if counter < counter_max then
        counter <= counter + 1;
    else
        counter <= 0;
        clk_aux <= not(clk_aux);
    end if;
end if;

end process;

end Behavioral;
