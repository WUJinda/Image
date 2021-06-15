![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image002.gif)

# **Project: Object recognition for coins calculation**

#### ***By WU Jinda***

# Introduction:

 

The coin calculation system can identify coins inside images captured using a phone camera, differentiate each coin and calculate the total value of money. This system consists of: some new coins, white background paper, phone camera, phone/PC connection cable, PC.

Figure 1 shows an example of calculation system which discovers one piece of 2 euros, one piece of 1 euros, one piece of 50 cents, 2 pieces of 20 cents, 1 piece of 10 cents, and 1 piece of 5 cents (total money value: 4.05 euros).

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image005.gif)

**Figure 1: Coins example (total: 4.05 Euros)**

# Dataset:

·     *Single –object case: 32 images(natural light)*

*– 2 images per side per coin*

·     *Multi-object case: 20 images(natural light)*

*![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image007.gif)*

https://drive.google.com/drive/folders/18LDiSaOk0eykG94LJhD1r3Bdm98dS8KY?usp=sharing

The data set includes a total of 52 pictures of coins. I took two shots of each side of each of the eight euro coins(one euro, two euros, 50 cents, 20 cents, 10 cents, 5 cents, 2 cents, 1 cent). The role of a single coin data set is to determine the parameters of various coins that I am interested in. The function of the data set of multiple coins is to test whether the parameters of a single coin meet the coin matching under real conditions.

# Methodology:

#  

### **1.**   **Image acquisition:**

In this part, using the mobile phone camera to take pictures for all the images at a fixed distance.

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image009.jpg)

 

Through measurement, the distance between the phone camera and the coin is 10cm.(Keep the plane of the phone camera parallel to the coin.)

The resolution of the photo is 3000x3000(1:1).

The background is white(On the white paper).

Natural light.

 

### **2.**   **Image processing in Matlab:**

 

**Step 1: Import the original image**

Because the resolution of the original image is too large, this will increase the workload of image manipulation and increase the time cost. Regarding this issue, I decided to reduce the impact of this problem by compressing the picture, but this reduces the accuracy of the picture, which means that the dynamic range of the threshold for filtering coins will become smaller.

In order to prepare for the morphological transformation, some pre-processing is performed: the image is converted into a grayscale image. Using filters to eliminate noise will blur the picture, so it is not used.

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image011.gif)

 

**Step 2: Morphological transformation**

Use the morphological transformation of the image to remove the background and focus on the coin.

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image013.gif)

**Step 3: Edge Detection**

The basic idea of edge detection is to (1) use the edge enhancement operator to highlight the local edge in the image, (2) then define the "edge strength" of the pixel, and extract the edge point set by setting the threshold. Due to the presence of noise and ambiguity, the monitored boundary may be widened or discontinued at a certain point. Therefore, boundary detection includes two basic contents:

i. Use the edge operator to extract the edge point set reflecting the gray level change

ii. Eliminate some boundary points or fill in gaps in the boundary from the set of edge points, and connect these edges into a complete line

Commonly used detection operators are differential operator, Laplacian Gaussian operator and canny operator.

**Sobel** operator is a form of filter operator to extract edges. After testing and comparison, the best edge detection effect can be achieved by using this operator in grayscale images.

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image015.gif)

After the edge detection operation, we will get some cloud points, select appropriate structural elements, and use **imclose** to link the contours of these cloud points.

The next thing we have to do is to use the **imfill** function to fill the holes.Because there will be a certain amount of noise in the processing, here the **bwareaopen** function is used to remove some small noises.

**Step 4: Set the threshold**

Perform granularity analysis on the processed image, find location of coin, and use the function(**regionprops**) to measure its diameter, area and center... 

To find classification criteria, put the training set (single object data set) into the function, and measured its related parameters and record them. And find the upper and lower limits of the diameter or area of various coins by observing the statistical data in order to set the range for the counting part. 

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image017.gif)

Here we decided to use area as the distinguishing criterion, because the resolution of the compressed image is not large, and there will be overlap if distinguished by diameter.

**Step 5: Get results**

By writing some conditional statements to complete the counting of different coins, and finally sum up to get the result.

# Experimental results:

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image019.gif) ![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image021.gif)

 

We can see that the detection effect for a single coin is very good.

Use a complete program to test the detection and counting of multiple coins:

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image023.gif)

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image025.gif)

 

This is the interface of the application(GUI OF MATLAB). 

We can load the picture and display it on the coordinate axis.

When you click the **Calculate** button, the program will quickly calculate the corresponding number of various coins and the total value of all coins on the picture.

The accuracy of this procedure is around 95%(50/52).

![img](file:///C:/Users/DAREWIN/AppData/Local/Temp/msohtmlclip1/01/clip_image027.gif)

 

#### **Unfinished work:**

 

In the process of research methods, I have tried to calculate the values or ratios of the three RGB channels of different coins to distinguish them by color. This detection effect could be better. However, in the original image or the part where the coin is extracted, the range of RGB change is not obvious. The reason may be that the camera environment is very dark or the coin itself becomes dirty and discolored.

 

# Description of the function:

·     **rgb2gray()**:

*[Input : RGB(image RGB)  Output : I(grayscale intensity image)]*

This function converts the truecolor image RGB to the grayscale intensity image I.

·     **imresize()**:

*[Input : A(image),[numrows numcols](* *two-element vector)     Output : B(image)]*

This function returns image B that has the number of rows and columns specified by the two-element vector [numrows numcols].

·     **imread()**: 

*[Input : filename (file path) Output : A(image)]*

This function  reads the image from the file specified by filename, inferring the format of the file from its contents. If filename is a multi-image file, then imread reads the first image in the file.

·     **imshow()**:

*[Input : I(image),[](adapt)        Output :null]*

This function displays the grayscale image I, scaling the display based on the range of pixel values in I.

·     **strel()**: 

*[Input : r(radius)   Output : SE(structuring element)]*

This function creates a disk-shaped structuring element, where r specifies the radius.

·     **imclose()**:

*[Input : I(image), SE(structuring element) Output : J(image)]*

This function performs morphological closing on the grayscale or binary image I, returning the closed image, J. SE is a single structuring element object returned by the strel or offsetstrel functions.

·     **edge()**:

*[Input : I(image), method('Sobel' (default) | 'Prewitt' | 'Roberts' | 'log' | 'zerocross' | 'Canny' | 'approxcanny')     Output :* *BW**(image)]*

This function detects edges in image I using the edge-detection algorithm specified by method.

·     **imfill()**:

*[Input : BW(image) Output : BW2(image)]*

This function fills holes in the input binary image BW. In this syntax, a hole is a set of background pixels that cannot be reached by filling in the background from the edge of the image.

·     **bwareaopen()**:

*[Input : BW(image), P(pixels)     Output : BW2(image)]*

This function removes all connected components (objects) that have fewer than P pixels from the binary image BW, producing another binary image, BW2.

·     **bwboundaries()**:

*[Input : BW(image) Output : [B,L](matrix)]*

This function returns a label matrix L where objects and holes are labeled.

·     **regionprops()**:

*[Input : L(label matrix L)   Output : stats(the set of properties)]*

This function returns measurements for the set of properties specified by properties for each labeled region in the label matrix L.

·     **sprint()**:

*[Input : formatSpec, A(arrays)    Output : str]*

This function formats the data in arrays A1,...,An according to formatSpec in column order, and returns the results to str.

# References:

https://stackoverflow.com/questions/26855264/identifying-different-coin-values-from-an-image-using-matlab

 



## DATA：

![image-20210615014652594](C:\Users\DAREWIN\AppData\Roaming\Typora\typora-user-images\image-20210615014652594.png)