library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity sobel_filter is
port (
clk : in std_logic;
rst : in std_logic;
file: in std_logic(15 downto 0);
file: out  std_logic_vector(15 downto 0);
);
end sobel_filter;

architecture structural of sobel_filter is
-- Define the required data type for reading binary expressions and writing to rame
type pixel_t  array (0 to 15) of std_logic_vector(15 downto 0);
type frame_t is array (0 to 255) of std_logic_vector (15 downto 0);

--Required data type definition for Sobel matrix application process
type output_t is array (0 to 255) of std_logic_vector(15 downto 0);

--Required variable definition for reading binary expressions
variable file : text;
variable pixel : pixel_t;
variable input_line : line;

-- Required variable definition for Sobel matrix application process
constant sobel_h : array (0 to 1, 0 to 2) of integer := ((-1, 0, 1), (-2, 0, 2));
constant sobel_v : array (0 to 2, 0 to 1) of integer := ((-1, -2), (0, 0), (1, 2));
variable frame : frame_t;
variable output : output_t;


begin
process (clk, rst)
begin
if rst = '1' then
-- Reset process
file := null;
pixel := (others => (others => '0'));
frame := (others => (others => (others => '0')));
output := (others => (others => (others => '0')));
elsif rising_edge(clk) then
-- open txt file
file := new text;
file_open(file, exampleImageBinaryFormat.txt, read_mode);


-- read txt file
while not endfile(file) loop
-- Her satırdaki pikselleri okuma
for i in pixel 'range loop
readline(file, input_line);
read(input_line, pixel(i));
end loop;



-- write to RAM
for row in 0 to 255 loop
  for col in 0 to 15 loop
    frame(row)(col) := pixel(row)(col);
  end loop;
end loop;
end loop;

-- close txt file
file_close(file);

-- Sobel matrix application process
for row in 1 to 254 loop
  for col in 1 to 14 loop
-- Horizontal output calculation
output(row)(col)(0) := frame(row-1)(col-1)(0) * sobel_h(0)(0) + frame(row-1)(col)(0) * sobel_h(0)(1) + frame(row-1)(col+1)(0) * sobel_h(0)(2) +
frame(row)(col-1)(0) * sobel_h(1)(0) + frame(row)(col)(0) * sobel_h(1)(1) + frame(row)(col+1)(0) * sobel_h(1)(2);
-- Vertical output calc.
output(row)(col)(1) := frame(row-1)(col-1)(1) * sobel_v(0)(0) + frame(row-1)(col)(1) * sobel_v(0)(1) +
frame(row)(col-1)(1) * sobel_v(1)(0) + frame(row)(col)(1) * sobel_v(1)(1) +
frame(row+1)(col-1)(1) * sobel_v(2)(0) + frame(row+1)(col)(1) * sobel_v(2)(1);
end loop;
end loop;

-- write to txt
file := new text;
file_open(file, "cıkısDosyasi.txt", write_mode);

--write output to txt file 
for row in 0 to 255 loop
for col in 0 to 15 loop
write(file, output(row)(col));
end loop;
end loop;

-- close txt file
file_close(file);

end process;

end structural ;
