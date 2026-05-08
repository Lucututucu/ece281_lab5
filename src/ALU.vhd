----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is

signal w_result: std_logic_vector(7 downto 0) := "11111111";
signal w_big_A: std_logic_vector(8 downto 0) := "000000000";
signal w_big_B_true: std_logic_vector(8 downto 0) := "000000000";
signal w_big_sum: std_logic_vector(8 downto 0);

--component ripple_adder is
--    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
--           B : in STD_LOGIC_VECTOR (7 downto 0);
--           Cin : in STD_LOGIC;
--           S : out STD_LOGIC_VECTOR (7 downto 0);
--           Cout : out STD_LOGIC
--    );
--end component ripple_adder;

begin

--ripple_adder_inst : ripple_adder
--    port map (
--        A => i_A,
--        B => w_B_true,
--        Cin => '0',
--        S => w_sum_result,
--        Cout => w_carry
--);	

--w_result <= w_sum_result when i_op = "000" else
--			w_sum_result when i_op = "001" else
--			(i_A AND i_B) when i_op = "010" else
--			(i_A OR i_B) when i_op = "011" else
--			"00000000";

w_result <= std_logic_vector(signed(i_A) + signed(i_B)) when i_op = "000" else
			std_logic_vector(signed(i_A) - signed(i_B)) when i_op = "001" else
			(i_A AND i_B) when i_op = "010" else
			(i_A OR i_B) when i_op = "011" else
			"00000000";

w_big_A(7 downto 0) <= i_A; 
w_big_B_true(7 downto 0) <= std_logic_vector(unsigned(NOT i_B) + 1) when i_op = "001" else
                            i_B;
w_big_sum <= std_logic_vector((unsigned(w_big_A) + unsigned(w_big_B_true)));

o_flags(3) <= w_result(7);
o_flags(2) <= '1' when w_result = "00000000" else
              '0';
o_flags(1) <= w_big_sum(8) when i_op = "001" else
              w_big_sum(8) when i_op = "000" else
              '0';
o_flags(0) <= ((NOT i_A(7)) AND (NOT i_B(7)) AND w_result(7)) OR (i_A(7) AND i_B(7) AND NOT w_result(7)) when i_op = "000" else
              (i_A(7) AND (NOT i_B(7)) AND (NOT w_result(7))) OR ((NOT i_A(7)) AND i_B(7) AND w_result(7)) when i_op = "001" else
              '0';

o_result <= w_result;


end Behavioral;
