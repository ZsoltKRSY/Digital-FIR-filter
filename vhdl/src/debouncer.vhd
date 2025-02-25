----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2024 12:34:54 PM
-- Design Name: 
-- Module Name: debouncer - Behavioral
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

entity debouncer is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           en : out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is

signal counter : std_logic_vector(15 downto 0) := (others => '0');
signal Q1, Q2, Q3 : std_logic := '0';

begin
    en <= Q2 and not(Q3);

    process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
            
            if counter = "1111111111111111" then
                Q1 <= btn;
            end if;
            
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
        
    end process;

end Behavioral;
