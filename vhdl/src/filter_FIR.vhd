----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2024 12:26:43 PM
-- Design Name: 
-- Module Name: filter_FIR - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity filter_FIR is
    Generic( input_width : INTEGER range 4 to 32 := 8;
             coeff_width : INTEGER range 4 to 32 := 8;
             nr_of_coeffs : INTEGER range 1 to 60 := 3;
             sampling_rate : INTEGER range 50 to 50_000_000 := 50_000_000);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           input_data : in STD_LOGIC_VECTOR (input_width - 1 downto 0);
           output_data : out STD_LOGIC_VECTOR (input_width + coeff_width - 1 downto 0));
end filter_FIR;

architecture Behavioral of filter_FIR is

attribute use_dsp: STRING;
attribute use_dsp of Behavioral: architecture is "yes";

component divizor_clk is
generic( generated_freq : INTEGER --Basys3 clock speed 100MHz
);
port ( clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      new_clk : out STD_LOGIC
);
end component;

type input_regs is array(0 to nr_of_coeffs - 1) of unsigned(input_width - 1 downto 0);
type mult_regs is array(0 to nr_of_coeffs - 1) of unsigned(input_width + coeff_width - 1 downto 0);
type dsp_regs is array(0 to nr_of_coeffs - 1) of unsigned(input_width + coeff_width - 1 downto 0);
type coeffs is array(0 to nr_of_coeffs - 1) of unsigned(coeff_width - 1 downto 0);

signal input_r: input_regs := (others => (others => '0')); -- registre pentru semnalul de intrare
signal mult_r: mult_regs := (others => (others => '0')); -- registre de multiplicare
signal sum_r: dsp_regs := (others => (others => '0')); -- registre de insumare
signal coeffs_r: coeffs := (
0=>x"01", -- a1
1=>x"02", -- a2
2=>x"03"  -- a3
); -- coeficientii filtrului

signal clk_fs: std_logic := '0'; --frecventa de esantionare

begin

output_data <= std_logic_vector(sum_r(0));
clk_fs <= clk; --clk, daca folosim clock-ul circuitului FPGA (frecventa nedivizata = 100MHz), punem in divizor de frecventa daca vrem o rata de esantionare mai mica

filter: process(rst, clk_fs)
begin
if rst = '1' then
    for i in 0 to nr_of_coeffs-1 loop
        input_r(i) <= (others => '0');
        mult_r(i) <= (others => '0');
        sum_r(i) <= (others => '0');
    end loop;
elsif rising_edge(clk_fs) and en = '1' then
    for i in 0 to nr_of_coeffs - 1 loop
        input_r(i) <= unsigned(input_data);
        
        mult_r(i) <= input_r(i) * coeffs_r(i);
        
        if i < nr_of_coeffs - 1 then
            sum_r(i) <= mult_r(i) + sum_r(i+1);
        else
            sum_r(i) <= mult_r(i);
        end if;
    end loop;  
end if;

end process;

generator_frecv_esantionare: divizor_clk
generic map(
    generated_freq => sampling_rate
)
port map(
    clk => clk,
    rst => rst,
    new_clk => open --clk_fs
);

end Behavioral;
