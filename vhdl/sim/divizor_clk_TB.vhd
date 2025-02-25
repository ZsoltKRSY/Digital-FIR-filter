----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2024 02:15:34 PM
-- Design Name: 
-- Module Name: divizor_clk_TB - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divizor_clk_TB is
--  Port ( );
end divizor_clk_TB;

architecture Behavioral of divizor_clk_TB is

component divizor_clk is
    Generic(
        generated_freq : INTEGER
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           new_clk : out STD_LOGIC
    );
end component;

signal clk_test: std_logic;
signal rst_test: std_logic;
signal new_clk_test: std_logic;

constant perioada: TIME := 10ns;


begin

divizor_clk_TB: divizor_clk
generic map (
    generated_freq => 50_000_000)
port map (
    clk => clk_test,
    rst => rst_test,
    new_clk => new_clk_test
);

process
begin
    clk_test <= '1';
    wait for perioada / 2;
    
    clk_test <= '0';
    wait for perioada / 2;
end process;

end Behavioral;
