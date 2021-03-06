[![CircleCI](https://circleci.com/gh/duckietown/duckietown-intnav.svg?style=shield)](https://circleci.com/gh/duckietown/duckietown-intnav)

[![Coverage Status](https://coveralls.io/repos/github/duckietown/duckietown-intnav/badge.svg?branch=master18)](https://coveralls.io/github/duckietown/duckietown-intnav?branch=master18)

# Project Unicorn - intnav

Project Unicorn is a project for AMOD Fall 2018 (ETH Zürich) course that focuses on Intersection Navigation for duckiebots in Duckietown.

duckietown-intnav contains the code to implement the intersection navigation demo on a duckiebot. The general idea of the projects consists of a 4-step approach to efficiently navigate the 3 and 4-way intersections: 

1- Starting at a red line at any intersection, the duckiebot estimates its initial pose.

2- Different paths for going left, right and straight are pre-computed and chosen depending on the desired intersection exit.

3- Constantly updating its pose estimate, it follows the path in a closed-loop manner with a PurePursuit controller.

4- Detects when the duckiebot has reached the intersection end (exit lane) and switches back to the duckietown lane follower.

The interested reader can find more details in the [Project documentation](http://docs.duckietown.org/DT18/opmanual_duckiebot/out/demo_projectunicorn.html).

## Software architecture

The code is split into two sections:

- **lib-intnav**: contains the logic architecture and algorithms of the demo implementation. It contains the following nodes:

	- *camera_config*
    - *kalman*
	- *planner*
	- *controller*
	- *imap* (used for visualization purposes only)

- **ros-intnav**: contains all nodes that enable the communication between lib-intnav (algorithms for calculation) and ROS (communicates with the duckiebot). It contains the following nodes:

	- *image_processing*: Uses *image_calibration*.
	- *april_activator*
	- *localization*: Uses *kalman*.
	- *controller*: Uses *controller*, *planner*.
	- *interface*
	- *tf_april_static*: Uses *tf* (external library).
	- *tf_cam_vehicle*: Uses *tf* (external library).
	- *visualization_imap*: Uses *imap*.

## Installation from source

We recommend to run our package natively: 

    $ cd lib-intnav
    $ pip install -r requirements.txt --user
    $ python setup.py develop --no-deps --user

To run the package using a virtual environment created by `pipenv` the following steps are necessary:

    $ pipenv install
    $ pipenv shell
    $ cd lib-intnav
    $ pip install -r requirements.txt
    $ python setup.py develop --no-deps

## Unit tests

Run this:

    $ make -C lib-intnav tests-clean tests
    
The output is generated in the folder in `lib-intnav/out-comptests/`.
