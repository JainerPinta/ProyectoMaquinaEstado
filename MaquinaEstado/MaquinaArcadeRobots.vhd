-- Jainer Pinta
-- Maquina de Estado: Arcade de Robots
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MaquinaArcade is
    Port ( clk, golpeR1, golpeR2, moneda : in  STD_LOGIC;
           ganadorR1, ganadorR2, disponible : out  STD_LOGIC;
           robotR1rounds, robotR2rounds, numROund: out  STD_LOGIC_VECTOR(1 downto 0);
           totalGolpesR1, totalGolpesR2 : out  integer range 0 to 10);
end MaquinaArcade;

architecture arqMaquinaArcade of MaquinaArcade is

type estados is (inicializar, jugar, sumarR1, sumarR2, asigRound, finalizar);
signal presente : estados := inicializar;

signal auxTotalGR1, auxTotalGR2 : integer range 0 to 10 := 0;
signal R1rounds, R2rounds, round : STD_LOGIC_VECTOR(1 downto 0) := "00";

begin
procesoJuego : process(clk, golpeR1, golpeR2, presente, moneda) begin
	if clk'event and clk = '1' then
		case (presente) is
			when inicializar => ganadorR1 <= '0'; ganadorR2 <= '0'; disponible <= '1'; R1rounds <= "00"; R2rounds <= "00";
						round <= "01"; auxTotalGR1 <= 0; auxTotalGR2 <= 0;
						if moneda = '1' then
							presente <= jugar;
						else
							presente <= inicializar;
						end if;
			when jugar => disponible <= '0';
						if golpeR1 = '1' then
							presente <= sumarR1;
						elsif golpeR2 = '1' then
							presente <= sumarR2;
						else
							presente <= jugar;
						end if;
			when sumarR1 =>
						if auxTotalGR1 = 10 then
							presente <= asigRound;
						else
							auxTotalGR1 <= auxTotalGR1 + 1;
							presente <= jugar;
						end if;
			when sumarR2 =>
						if auxTotalGR2 = 10 then
							presente <= asigRound;
						else
							auxTotalGR2 <= auxTotalGR2 + 1;
							presente <= jugar;
						end if;
			when asigRound => 
						round <= round +1 ;
						if auxTotalGR1 = 10 then
							R1rounds <= R1rounds + 1;
						else
							R2rounds <= R2rounds + 1;
						end if;
						if round = "11" then
							round <= "01";
							presente <= finalizar;
						else
							auxTotalGR1 <= 0;
							auxTotalGR2 <= 0;
							presente <= jugar;
						end if;
			when finalizar =>
					if R1rounds = "01" or R1rounds = "00" then
						ganadorR2 <= '1';
						ganadorR1 <= '0';
					else
						ganadorR1 <= '1';
						ganadorR2 <= '0';
					end if;
					presente <= inicializar;
		end case;
	end if;
	end process procesoJuego;
	
	totalGolpesR1 <= auxTotalGR1; totalGolpesR2 <= auxTotalGR2;
	robotR1rounds <= R1rounds; robotR2rounds <= R2rounds;
	numRound <= round;
end arqMaquinaArcade;

