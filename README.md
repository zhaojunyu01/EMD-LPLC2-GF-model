# EMD-LPLC2-GF-model

Released on: 2022-12-25

The repository includes matlab codes associated with the manuscript "A fly inspired solution to looming detection for collision avoidance".  

All the codes were written by JunYu Zhao and Shengkai Xi as specifically denoted in each program, except that the initial version of the code simulating the EMD array was contributed by Zhihua Wu.

In the 'code' folder, the specific codes were organized by tasks and can be divided into three categories as follows.

A. CORE MODEL PROGRAMS
 1. GF.m
 2. loom.m
 3. lplc2conv2.m
 4. emd.m
 5. OffRect.m
 6. OnRect.m
 7. LIF.m

B. STIMULUS RELATED PROGRAMS
 8. loomingObject.m
 9. shiftBg.m
 10. boxSpawn.m

C. RESULTS DISPLAYING RELATED PROGRAMS
 11. ResultShow.m
 12. ROS_Avoidance.m
 13. replot.m

The robot related tasks were running on closed-loop simulations, which were performed by communications between the EMD‒LPLC2‒GF model under Windows and virtual robots under Ubuntu 16.04. Specifically, we installed Ubuntu 16.04 into Windows via VMware Workstation Pro, into which the Robot Operating System (ROS) and physical simulation environment Gazebo were then installed. By utilizing the ROS interface of the MATLAB ROS toolbox, the EMD‒LPLC2‒GF model programmed in MATLAB was able to collect real-time visual input signals from a camera mounted on ROS controlled TurtleBot 3.0 virtual robots (specific type: turtlebot3_waffle_pi). The robot camera has a 120-degree field of view.
