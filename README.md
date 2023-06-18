# ImageProcessing
Image Processing with VHDL
"Sobel Edge Detection
The Sobel filter is used in edge detection algorithms, image processing, and computer vision, particularly to emphasize edges in an image.
Since the intensity function of a digital image is known only at discrete points, its derivatives cannot be defined unless we assume there is an underlying differentiable intensity function. With some additional assumptions, the derivative of the continuous intensity function can be computed as a function on the digital image, i.e., as a function on the sampled intensity values. It was discovered that the derivatives at any point are functions of the intensity values of nearly all image points. However, the approximations of these derivative functions can be defined with varying degrees of accuracy, either less or greater.
The Sobel-Feldman operator represents a rather crude approximation of the image gradient, but it is still of sufficient quality for practical use in many applications. More specifically, it uses only the intensity values in a 3x3 region around each image point to approximate the corresponding image gradient and uses only integer values for the coefficients that weight the image intensities to produce the gradient approximation.

Project code description:
1. Firstly, the image file is converted into a binary representation.
2. In the entity section, input and output signals and ports are defined.
          entity sobel_filter is 
          port (clk: in std_logic;
          rst: in std_logic;
          file: in std_logic_vector(15 downto 0);
          file: out std_logic_vector(15 downto 0));
          end sobel_filter;
3. In the architecture section, processes and loops are created to apply the Sobel matrix. The project is completed."
