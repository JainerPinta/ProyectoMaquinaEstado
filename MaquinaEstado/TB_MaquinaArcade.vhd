--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:53:46 01/02/2022
-- Design Name:   
-- Module Name:   /home/ise/Desktop/Proyectos/MaquinaEstado/TB_MaquinaArcade.vhd
-- Project Name:  MaquinaEstado
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MaquinaArcade
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_MaquinaArcade IS
END TB_MaquinaArcade;
 
ARCHITECTURE behavior OF TB_MaquinaArcade IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MaquinaArcade
    PORT(
         clk : IN  std_logic;
         golpeR1 : IN  std_logic;
         golpeR2 : IN  std_logic;
         moneda : IN  std_logic;
         ganadorR1 : OUT  std_logic;
         ganadorR2 : OUT  std_logic;
         disponible : OUT  std_logic;
         robotR1rounds : OUT  std_logic_vector(1 downto 0);
         robotR2rounds : OUT  std_logic_vector(1 downto 0);
         numRound : OUT  std_logic_vector(1 downto 0);
         totalGolpesR1 : OUT  integer range 0 to 10;
         totalGolpesR2 : OUT  integer range 0 to 10
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal golpeR1 : std_logic := '0';
   signal golpeR2 : std_logic := '0';
   signal moneda : std_logic := '0';

 	--Outputs
   signal ganadorR1 : std_logic;
   signal ganadorR2 : std_logic;
   signal disponible : std_logic;
   signal robotR1rounds : std_logic_vector(1 downto 0);
   signal robotR2rounds : std_logic_vector(1 downto 0);
   signal numRound : std_logic_vector(1 downto 0);
   signal totalGolpesR1 : integer range 0 to 10;
   signal totalGolpesR2 : integer range 0 to 10;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MaquinaArcade PORT MAP (
          clk => clk,
          golpeR1 => golpeR1,
          golpeR2 => golpeR2,
          moneda => moneda,
          ganadorR1 => ganadorR1,
          ganadorR2 => ganadorR2,
          disponible => disponible,
          robotR1rounds => robotR1rounds,
          robotR2rounds => robotR2rounds,
          numRound => numRound,
          totalGolpesR1 => totalGolpesR1,
          totalGolpesR2 => totalGolpesR2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		moneda <= '1';
      wait for clk_period;
		moneda <= '0';
		golpeR1 <= '1';
		golpeR2 <= '0';
		wait for clk_period*20;
		golpeR2 <= '1';
		golpeR1 <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
