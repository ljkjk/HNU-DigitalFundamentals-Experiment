library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity GR is
	port(CLK, WE_GR: in std_logic;
		RWBA, RAA: in std_logic_vector(1 downto 0);
		BUS_DATA: in std_logic_vector(7 downto 0);
		A, B: out std_logic_vector(7 downto 0);
		OUTPUT_A, OUTPUT_B, OUTPUT_C: out std_logic_vector(7 downto 0));
end GR;

architecture bhv of GR is
signal IR_A, IR_B, IR_C: std_logic_vector(7 downto 0);
begin
	A <= IR_A when RAA = "00" else
		 IR_B when RAA = "01" else
		 IR_C;
	B <= IR_A when RWBA = "00" else
		 IR_B when RWBA = "01" else
		 IR_C;	
	process(CLK, WE_GR)
	begin
		if(CLK'event and CLK = '0') then
			if(WE_GR = '0') then
				if(RWBA = "00") then
					IR_A <= BUS_DATA;
				elsif(RWBA = "01") then
					IR_B <= BUS_DATA;
				elsif(RWBA = "10" or RWBA = "11") then
					IR_C <= BUS_DATA;
				end if;
			end if;
		end if;
	end process;	
	
	OUTPUT_A <= IR_A;
	OUTPUT_B <= IR_B;
	OUTPUT_C <= IR_C;
end bhv;

	
