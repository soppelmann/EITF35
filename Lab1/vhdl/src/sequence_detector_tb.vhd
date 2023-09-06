library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity sequence_detector_tb is
end sequence_detector_tb;

architecture behavioural of sequence_detector_tb is

    component stimulus_generator is
        generic (
            FILE_NAME: string := "stimuli.txt";
            SAMPLE_WIDTH: positive
        );
        port (
            clk: in std_logic;
            reset: in std_logic;
            data_valid : out std_logic;
            stimulus_stream : out std_logic_vector(3 downto 0)
        );
    end component;

   component par2ser is
    port (
        clk: in std_logic;
        reset_n: in std_logic;
        data_parallel: in std_logic_vector(3 downto 0);
        data_serial: out std_logic
    );
   end component;
   
   component sequence_detector_moore is
        port (
        clk: in std_logic;
        reset_n: in std_logic;
        data_serial : in std_logic;
        data_valid : in std_logic;
        data_out: out std_logic
    );
    end component;
    
    component sequence_detector_mealy is
        port (
        clk: in std_logic;
        reset_n: in std_logic;
        data_serial : in std_logic;
        data_valid : in std_logic;
        data_out: out std_logic
    );
    end component;
    
    constant CLOCK_PERIOD: time := 100 ns;
    constant RESET_STOP: time := 150 ns;
        
    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    
    signal bit_stream: std_logic_vector(3 downto 0) := (others => '0');
    signal data_serial: std_logic;
    signal data_valid : std_logic;
    
    signal moore_detected: std_logic;
    signal mealy_detected: std_logic;

    signal moore_count: integer := 0;
    signal mealy_count: integer := 0;    

begin

    reset <= '1' after RESET_STOP;
           
    clk <= not clk after CLOCK_PERIOD / 2;
    
    -- Read values from stimuli.txt file
    stimuli_gen: stimulus_generator
        generic map (
            FILE_NAME => "stimuli.txt",
            SAMPLE_WIDTH => 4
        )
        port map (
            clk => clk,
            reset => reset,
            data_valid => data_valid,
            stimulus_stream => bit_stream
    );
    
    -- initialize unit under test (UUT)    
    p2s_converter : par2ser 
    port map(
        clk => clk,
        reset_n => reset,
        data_parallel => bit_stream,
        data_serial => data_serial
        --d_valid => d_valid
    );

    uut_moore: sequence_detector_moore 
         port map(
        clk => clk,
        reset_n => reset,
        data_serial => data_serial,
        data_valid => data_valid,
        data_out => moore_detected
    );

    uut_mealy: sequence_detector_mealy 
        port map (
            clk => clk,
            reset_n => reset,
            data_serial => data_serial,
            data_valid => data_valid,
            data_out => mealy_detected
        );

    detection_counter: process (moore_detected, mealy_detected, moore_count, mealy_count, reset)
    begin
        if reset = '0' then
            moore_count <= 0;
            mealy_count <= 0;
        else
            -- create counters here to count sequence occurrences for both mealy and moore implementations
            -- ???
            -- ???
        end if;
    end process;
end;
