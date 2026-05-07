----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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

entity controller_fsm is
    Port ( i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is

	signal f_state: std_logic_vector(1 downto 0) := "00";
	signal f_state_next: std_logic_vector(1 downto 0) := "00";
	
begin	
	
	-- PROCESSES ----------------------------------------
	twoBitCounter_proc : process(i_adv, i_reset)
	begin
		if i_reset = '1' then
			f_state <= "00";
		elsif rising_edge(i_adv) then
		    f_state <= f_state_next;
		end if;
	end process twoBitCounter_proc;
	-----------------------------------------------------
	

	-- CONCURRENT STATEMENTS ----------------------------
	
	o_cycle <= "0001" when f_state = "00" else
			  "0010" when f_state = "01" else
			  "0100" when f_state = "10" else
			  "1000";

    
    f_state_next <= "01" when f_state = "00" else
                    "10" when f_state = "01" else
                    "11" when f_state = "10" else
                    "00";

end FSM;
