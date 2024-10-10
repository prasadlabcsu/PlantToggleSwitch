Instruction on plant image processing protocol
General information 
The most current version for whole plant image processing protocol is Shell3.m. 
This Matlab script requires image processing toolbox. 
Inputs: 
System parameters: 
Leaves_Threshold2 	-- default starting threshold value for leaves  
Root_Threshold 	-- default starting threshold value for roots   
If_Dynamics 	-- default value for “if dynamics of luciferase signal during the imaging is interested?”. 1 for Yes and 0 for No. If 1 is specified, an output file will be generated for each image in the folder containing Luciferase images and results in a longer processing time. 
Except for the If_Dynamics, the other two parameters usually need no change. 

Instructions on processing steps: 
Step 1: select the files need processing using user interface. 
1.	“Select the COLOR Image Collected by a Regular Camera”
This step selects the color image of plants collected by a regular digital camera. This image will be used as the original mask for plant leaves and roots. 
2.	“Select the Bright-Field Image Collected by the Luciferase Camera”
This step selects the bright-field image collected by the luciferase camera. This image will be used to align the mask obtained from the color image to the plants imaged by the luciferase camera. 
3.	“Select the Folder Containing the Corresponding Luciferase Images”. 
This step selects the folder containing the luciferase images corresponding to the plants in images selected in Step 1.1 and Step 1.2. The images in this folder hold the luciferase intensities. 

Step 2: select the region of interest (ROI) in the Color Image. 
ROI is defined as the region containing all the plants here. Drag the pointer to create a minimal box containing all the plants. Avoid parts of the plates and other features if possible. Double click anywhere inside the box to confirm the selection. 

Step 3: set the threshold of leaves. 
In this user interface, the upper panel shows the thresholded leaves using the current value of the threshold. The lower part has the slide bar, which can be used to change the value of the threshold. The default value is 1. Each time the slide bar is changed, the thresholded leaves will be updated. 
Change the threshold to a minimal value so that all parts of the leaves are shown in the upper panel clearly and minimal background is thresholded. Close the user interface by click the red “X” in the upper right corner of the window (upper left for UNIX platforms, including iOS.). 

Note: Have the leaves thresholded as complete as possible is the first priority here. Some parts of the background are acceptable here, which can be removed in Step 4. 

Step 4: remove background manually if needed. 
In this user interface, the left panel shows the original ROI selected in the Color Image and the right panel shows the thresholded leaves for comparisons. A question dialog box appears to ask “Do you want to cut the Leaves?”. 
If some parts of the background was thresholded in the previous step, this step allows manual adjustments. 
If no adjustment is needed, click No and proceed to next step. 
If some adjustments are needed, click Yes. If Yes is clicked, the pointer changes into cross-shaped when posited inside the right panel. Hold the left button of the mouse to draw a freehand line. Double click inside the shape to confirm the selection. Then, a question dialog box appears to ask “What do you want to operate?”. 
If “Stroke” is selected, a linear cut (the pixels under the freehand line will be deleted from the thresholded leaves) will be performed. 
When “Chunk” selected, the area enclosed by the freehand line will be deleted. 
When “Recover” selected, the area enclosed by the freehand line will be revered back to the very beginning of this step, which is same as the result of Step 3. Use the combinations of these three steps to achieve desired outcomes. When all wanted manual adjustments are done, click “No” when asked “Do you want to cut the Leaves?” to proceed to the next step. 

Step 5: Quality control of threholding the leaves. 
In this step, the figure shows the original ROI selected in the Color Image with the thresholded leaves outlined and numbered. The number appears at the upper right of the bounding box of a ROI. A question dialog box appears to ask “Do you have # Leaves?”.
If the outcome is as expected, click “Yes” to proceed to next step. 
If not, click “No” to go back to Step 4 to do more adjustment. 
If needed, click “Start Over” to go back to the beginning of the manual adjustment with all adjustments reverted. 

Note: Steps 6 – 8 are very similar to Steps 3 – 5, skim over after careful reading on Steps 3 – 5. 

Step 6: set the threshold of roots. 
In this user interface, the left panel shows the original ROI selected in the Color Image. The right panel shows the thresholded roots using the current value of the threshold. In the lower right part lies the slide bar, which can be used to change the value of the threshold. The default value is 0.9. Each time the slide bar is changed, the thresholded roots will be updated. 
Change the threshold to a minimal value so that all parts of the roots are shown in the upper panel clearly and minimal background is thresholded. Close the user interface by click the red “X” in the upper right corner of the window (upper left for UNIX platforms, including iOS.). 

Note: 
1) No need to worry about the leaves also thresholded here, which will be removed automatically in a later step.  
2) Have the roots thresholded as complete as possible is the first priority here. Some parts of the background are acceptable here, which can be removed in Step 4. 

Step 7: remove background manually if needed. 
In this user interface, the left panel shows the original ROI selected in the Color Image and the right panel shows the thresholded roots for comparisons. A question dialog box appears to ask “Do you want to cut the Root?”. 
If some parts of the background was thresholded in the previous step, this step allows manual adjustments. 
If no adjustment is needed, click No and proceed to next step. 
If some adjustments are needed, click Yes. If Yes is clicked, the pointer changes into cross-shaped when posited inside the right panel. Hold the left button of the mouse to draw a freehand line. Double click inside the shape to confirm the selection. Then, a question dialog box appears to ask “What do you want to operate?”. 
If “Stroke” is selected, a linear cut (the pixels under the freehand line will be deleted from the thresholded roots) will be performed. 
When “Chunk” selected, the area enclosed by the freehand line will be deleted. 
When “Recover” selected, the area enclosed by the freehand line will be revered back to the very beginning of this step, which is same as the result of Step 6. Use the combinations of these three steps to achieve desired outcomes. When all wanted manual adjustments are done, click “No” when asked “Do you want to cut the Root?” to proceed to the next step. 

Step 8: Quality control of thresholding the leaves. 
In this step, the figure shows the original ROI selected in the Color Image with the thresholded leaves outlined and numbered. The number appears at the upper right of the bounding box of a ROI. A question dialog box appears to ask “Do you have # Leaves?”.
If the outcome is as expected, click “Yes” to proceed to next step. 
If not, click “No” to go back to Step 4 to do more adjustment. 
If needed, click “Start Over” to go back to the beginning of the manual adjustment with all adjustments reverted. 

Note: due to some technical difficulties, the numbers may be overlapping sometimes. Pay attentions when this happens. 

Step 9: alignment of the Color Image and the Bright-Field Image collected by the Luciferase camera. 
In this user interface, the left half shows the ROI selected in the Color Image and the right the Bright-Field Image. The lower part shows the two original images and the upper part their zoomed-in counterparts. The boxes shown in the original images are draggable and the enclosed parts are zoomed in in the upper part. 
Click on the same identifiable points sequentially on each side. For example, the center of a plant is a good candidate as one identifiable point. Other points as long as clearly identifiable on both the Color Image and the Bright-Field Image are equally good. Click one point on the left and click its counterpart on the right. Repeat this to select at least 3 pairs (4 is recommended for better accuracy). When done, click “File” on the upper left and select “Close control point selection tool” (with hot key of Ctrl + W). 

Note: close the window directly by clicking the red X as in previous step will cause error and stop the protocol. 

Step 10: Quality control of the alignment. 
In this step, the figure shows the overlap of the two images with the Color Image in a green tune and the Bright-Field Image in a red tune. A question dialog box appears to ask “Are you satisfied with the mask mapping?”. 
Click “Yes” to proceed to the next step. 
Click “No” to go back to Step 9. 

Step 11: enter the index number of plants processed here. 
1.	In this step, an input dialog box appears to ask “How many plants do you have in this plate?”. 
Enter the number you have and click “OK”. 
2.	In this step, an input dialog box appears to ask “Please Enter Plant Index Number”. 
This step allows the user to enter the index number of each plant inside the plate one by one. The order is from left to right and top to bottom. If a dataset containing multiple plates is processed, the index of each plant should be unique. Enter the index number and click “OK”. 
3.	A question dialog box appears asking “Are you sure about the input listed in the Command Line?” as a quality control step. 
User should look at the command line of Matlab to double check if correct total number of plants and correct plant indexing numbers have been input. 
If everything is correct, click “Yes” to proceed. 
If not, clicking “No” will bring you back to the beginning of Step 11. 

Step 12: Final check of the leaves mask and group them into corresponding plants. 
The operation is same as in the two previous thresholding steps and is not repeated here. 
After double checking the leaves mask, an input dialog box appears to ask “Number of Leaves” for each plant following the order of left to right and top to bottom. Enter the number of leaves for a corresponding plant and click “OK”. Then, an input dialog box appears for each ROI of Leaves to ask “Index of (Plant Index here) Leaves”. Enter the indexes of leave ROIs one by one and click “OK” each time. No order should be followed when entering the ROI index for one plant, although ascending order is recommended to be organized. 
After all indexes of leave ROI are inputted for each plant, a question dialog appears to ask “Are you sure about the input listed in the Command Line?” as a same quality control step. Follow the same instruction as in previous step. 

Step 13: Final check of the roots mask and group them into corresponding plants. 
The operation is same as in the previous steps and is not repeated here. 
After double checking the roots mask, an input dialog box appears to ask “Number of Roots” for each plant following the order of left to right and top to bottom. Enter the number of leaves for a corresponding plant and click “OK”. Then, an input dialog box appears for each ROI of Roots to ask “Index of (Plant Index here) Roots”. Enter the indexes of root ROIs one by one and click “OK” each time. No order should be followed when entering the ROI index for one plant, although ascending order is recommended to be organized. 
After all indexes of root ROI are inputted for each plant, a question dialog appears to ask “Are you sure about the input listed in the Command Line?” as a same quality control step. Follow the same instruction as in previous steps. 

Outputs: 
Then, the ROIs of each plant will be applied to the Luciferase Images identified in the Luciferase folder. Results are output into the folder containing the Color Image and Bright-Field Image. The ROI mask of leaves, roots and whole plants of each plant can also be found in that folder. 

