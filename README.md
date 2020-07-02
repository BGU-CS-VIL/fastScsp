# fastSCSP
## A Fast Method for Inferring High-Quality Simply-Connected Superpixels
---------------------------------------------------------------------

This repo is similar to the one in [https://github.com/freifeld/fastSCSP/](https://github.com/freifeld/fastSCSP/),
except that **the old Python 2 wrapper was replaced with a Python 3 wrapper**. 
The C++ and Matlab wrappers have not been changed. 

This implementation is based on the algorithm from [\[Freifeld, Li and Fisher, ICIP '15\]](http://groups.csail.mit.edu/vision/sli/projects/fastSCSP/FreifeldLiFisher_ICIP15.pdf).
See also the [project page](http://groups.csail.mit.edu/vision/sli/projects.php?name=fastSCSP).

Note that in ICCV 2019 we released a better superpixel method, called [Bayesian Adaptive Superpixel Segmentation](https://github.com/BGU-CS-VIL/BASS).

This software is released under the MIT License (included with the software).
Note, however, that if you use this code (and/or the results of running it) 
to support any form of publication (e.g.,a book, a journal paper, 
a conference paper, a patent application, etc.), then we ask you to cite
the following paper:

	@incollection{Freifeld:ICIP:2015,
	  title={A Fast Method for Inferring High-Quality Simply-Connected Superpixels},
	  author={Freifeld, Oren and Li, Yixin and Fisher III, John W},
	  booktitle={International Conference on Image Processing},
	  year={2015},
	}
	
	
Instructions: 
-------------------------
Please see the original repository:
[https://github.com/freifeld/fastSCSP/](https://github.com/freifeld/fastSCSP/)	

Authors of this software: 
-------------------------

Batel Steiner (email: batelst@post.bgu.ac.il)

Yixin Li (email: liyixin@mit.edu)

Oren Freifeld  (email: freifeld@csail.mit.edu)

An early/partial version of this software, using python and CUDA, was written by Oren. It was then completed and improved by Yixin, who also wrote the Matlab and C++ wrappers.  In 2019, Batel replaced the Python 2 wrapper with a Python 3 wrapper.
