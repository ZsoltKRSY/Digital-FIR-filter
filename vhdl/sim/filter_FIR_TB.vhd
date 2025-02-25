----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2024 06:14:02 PM
-- Design Name: 
-- Module Name: filter_FIR_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity filter_FIR_TB is
--  Port ( );
end filter_FIR_TB;

architecture Behavioral of filter_FIR_TB is

component filter_FIR is
Generic( input_width : INTEGER;
            coeff_width : INTEGER;
            sampling_rate : INTEGER
); --dat in Hz (maximul este 100MHz = 100.000.000Hz)
Port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en : in STD_LOGIC;
        input_data : in STD_LOGIC_VECTOR (input_width - 1 downto 0);
        output_data : out STD_LOGIC_VECTOR (input_width + coeff_width - 1 downto 0)
);
end component;

signal clk_test: std_logic;
signal rst_test: std_logic := '0';
signal en_test: std_logic := '1';
signal input_data_test: std_logic_vector(15 downto 0);
signal output_data_test: std_logic_vector(31 downto 0);

constant perioada: TIME := 10ns;

begin

filter_FIR_TB: filter_FIR
generic map (
    input_width => 16,
    coeff_width => 16,
    sampling_rate => 50_000_000)
port map (
    clk => clk_test,
    rst => rst_test,
    en => en_test,
    input_data => input_data_test,
    output_data => output_data_test
);

process
begin
    clk_test <= '1';
    wait for perioada / 2;
    clk_test <= '0';
    wait for perioada / 2;

    input_data_test <= x"0002";
    clk_test <= '1';
    wait for perioada / 2;
    clk_test <= '0';
    wait for perioada / 2;
    
    input_data_test <= x"000C";
    clk_test <= '1';
    wait for perioada / 2;
    clk_test <= '0';
    wait for perioada / 2;
    
    input_data_test <= x"0010";
    clk_test <= '1';
    wait for perioada / 2;
    clk_test <= '0';
    wait for perioada / 2;
    
    input_data_test <= x"000F";
    clk_test <= '1';
    wait for perioada / 2;
    clk_test <= '0';
    wait for perioada / 2;
    
    input_data_test <= x"0001";
    clk_test <= '1';
    wait for perioada / 2;
    clk_test <= '0';
    wait for perioada / 2;
    
end process;

end Behavioral;
