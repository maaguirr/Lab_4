library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_Testbench is
end entity ALU_Testbench;

architecture testbench of ALU_Testbench is
  component ALU is
    port (
      DataIn1: in std_logic_vector(31 downto 0);
      DataIn2: in std_logic_vector(31 downto 0);
      ALUCtrl: in std_logic_vector(4 downto 0);
      Zero: out std_logic;
      ALUResult: out std_logic_vector(31 downto 0)
    );
  end component ALU;

  signal DataIn1_tb, DataIn2_tb: std_logic_vector(31 downto 0);
  signal ALUCtrl_tb: std_logic_vector(4 downto 0);
  signal Zero_tb: std_logic;
  signal ALUResult_tb: std_logic_vector(31 downto 0);

begin
  DUT: ALU port map (
    DataIn1 => DataIn1_tb,
    DataIn2 => DataIn2_tb,
    ALUCtrl => ALUCtrl_tb,
    Zero => Zero_tb,
    ALUResult => ALUResult_tb
  );

  -- Stimulus process
  stim_proc: process
  begin
	  
	-- Test case 1: Immediate pass through
    DataIn1_tb <= "10101010101010101010101010101010";
    DataIn2_tb <= "00000000000000000000000000001111";
    ALUCtrl_tb <= "00000"; -- Immediate pass through
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "00000000000000000000000000001111"

    -- Test case 2: Addition
    DataIn1_tb <= "00000000000000000000000000000100";
    DataIn2_tb <= "00000000000000000000000000000011";
    ALUCtrl_tb <= "00001"; -- Addition
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "00000000000000000000000000000111" 
	
	-- Test case 3: Subtraction
    DataIn1_tb <= "00000000000000000000000000000100";
    DataIn2_tb <= "00000000000000000000000000000011";
    ALUCtrl_tb <= "10010"; -- Addition
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "00000000000000000000000000000001" 
	
	-- Test case 4: Addi - DataIn2 will be converted to a signed value outside the ALU
    DataIn1_tb <= "00000000000000000000000000000100";
    --DataIn2_tb <= "11111111111111111111111111111101";
	DataIn2_tb <= "11111101100110101000101111000111";
    ALUCtrl_tb <= "00011"; -- Addi
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "11111101100110101000101111001011"
	
	-- Test case 5: Addi
    DataIn1_tb <= "00000000000000000000000000000100";
    DataIn2_tb <= "00000000000000000000000000000011";
    ALUCtrl_tb <= "00011"; -- Addi
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "00000000000000000000000000000111" 
	
    ---- Test case 6: Bitwise AND
--    DataIn1_tb <= "11110000111100001111000011110000";
--    DataIn2_tb <= "00001111000011110000111100001111";
--    ALUCtrl_tb <= "00100"; -- Bitwise AND
--    wait for 20 ns;
--    -- Expected output: ALUResult_tb = "00000000000000000000000000000000"
	
	-- Test case 6: Bitwise AND
    DataIn1_tb <= "00000000000000000000000000001111";
    DataIn2_tb <= "00000000000000000000000000000000";
    ALUCtrl_tb <= "00100"; -- Bitwise AND
    wait for 20 ns;
    -- Expected output: ALUResult_tb = ""		 
	
	-- Test case 6.1: Bitwise AND
    DataIn1_tb <= "00000000000000000000000000001111";
    DataIn2_tb <= "00000000000000000000000000001111";
    ALUCtrl_tb <= "00100"; -- Bitwise AND
    wait for 20 ns;
    -- Expected output: ALUResult_tb = ""
	
	-- Test case 7: Bitwise ANDi
    DataIn1_tb <= "11110000111100001111000011110000";
    DataIn2_tb <= "11110000111100001111000011110000";
    ALUCtrl_tb <= "00101"; -- Bitwise ANDi
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "11110000111100001111000011110000"  
	
    -- Test case 8: Bitwise OR
	DataIn1_tb <= "11001100110011001100110011001100";
	DataIn2_tb <= "11001010110011001100110011001100";
				 --11001110110011001100110011001100
	ALUCtrl_tb <= "00110"; -- OR 
	wait for 20 ns;
	-- Expected output: ALUResult_tb = "11001110110011001100110011001100"
	
	-- Test case 8.1: Bitwise OR
	DataIn1_tb <= "00000000000000000000000000001111";
	DataIn2_tb <= "00000000000000000000000011110000";
				 --11001110110011001100110011001100
	ALUCtrl_tb <= "00110"; -- OR 
	wait for 20 ns;
	-- Expected output: ALUResult_tb = ""
	
	-- Test case 8.2: Bitwise OR
	DataIn1_tb <= "00000000000000000000000000001111";
	DataIn2_tb <= "00000000000000000000000000000000";
				 --11001110110011001100110011001100
	ALUCtrl_tb <= "00110"; -- OR 
	wait for 20 ns;
	-- Expected output: ALUResult_tb = ""
	
	-- Test case 9: Bitwise ORi
	DataIn1_tb <= "11001100110011001100110011001100";
	DataIn2_tb <= "11001010110011001100110011001100";
	ALUCtrl_tb <= "00111"; 
	wait for 20 ns;
	-- Expected output: ALUResult_tb = "11001110110011001100110011001100" 
    
    ---- Test case 10: Shift left logical by 1
--    DataIn1_tb <= "11001100110011001100110011001100";
--    DataIn2_tb <= "00000000000000000000000000000001";
--    ALUCtrl_tb <= "01000"; -- Shift left logical
--    wait for 20 ns;
--    -- Expected output: ALUResult_tb = "10011001100110011001100110011000"
	
	 -- Test case 11: Shift left logical by 2
    DataIn1_tb <= "11001100110011001100110011001100";
    DataIn2_tb <= "00000000000000000000000000000010";
    ALUCtrl_tb <= "01000"; 
    wait for 20 ns;
     -- Expected output: ALUResult_tb = "00110011001100110011001100110000"
	
	-- Test case 11.1: Shift left logical by 2
    DataIn1_tb <= "00000000000000000000000000000110";
    DataIn2_tb <= "00000000000000000000000000000010";
    ALUCtrl_tb <= "01000"; 
    wait for 20 ns;
    -- Expected output: ALUResult_tb = ""
	
	-- Test case 12: Shift left logical by 3
    DataIn1_tb <= "11001100110011001100110011001100";
    DataIn2_tb <= "00000000000000000000000000000011";
    ALUCtrl_tb <= "01000"; 
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "01100110011001100110011001100000"
	
	-- Test case 13: Shift right logical by 1
    DataIn1_tb <= "11001100110011001100110011001100";
    DataIn2_tb <= "00000000000000000000000000000001";
    ALUCtrl_tb <= "11000"; -- Shift right logical
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "01100110011001100110011001100110"
	
	-- Test case 14: Shift right logical by 2
    DataIn1_tb <= "00000000000000000000000000000110";
    DataIn2_tb <= "00000000000000000000000000000010";
    ALUCtrl_tb <= "11000"; 
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "00110011001100110011001100110011"
	
	-- Test case 15: Shift right logical by 3
    DataIn1_tb <= "11001100110011001100110011001100";
    DataIn2_tb <= "00000000000000000000000000000011";
    ALUCtrl_tb <= "11000";
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "00011001100110011001100110011001"
	
	-- Test case 16: Shift right logical by 4?
    DataIn1_tb <= "11001100110011001100110011001100";
    DataIn2_tb <= "00000000000000000000000000000100";
    ALUCtrl_tb <= "11000";
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "11001100110011001100110011001100" 
	
	-- Test case 17: Shift left logical i by 3
    DataIn1_tb <= "00000000000000000000000000000110";
    DataIn2_tb <= "00000000000000000000000000000011";
    ALUCtrl_tb <= "01100";
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "01100110011001100110011001100000"
	
	-- Test case 18: Shift right logical i by 3
    DataIn1_tb <= "00000000000000000000000000000110";
    DataIn2_tb <= "00000000000000000000000000000011";
    ALUCtrl_tb <= "11100"; 
    wait for 20 ns;
    -- Expected output: ALUResult_tb = "00011001100110011001100110011001"


    
	wait;
  end process stim_proc;

end architecture testbench;