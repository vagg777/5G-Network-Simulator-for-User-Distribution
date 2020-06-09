
# MATLAB 5G Network Simulator and User Distribution Algorithm

**Note**: This MATLAB simulation is part of a research paper contribution, presented in the International Symposium on Networks, Computers and Communications (ISNCC) in 2019 and later published in the IEEE platform.
You can download the research paper from this link: https://ieeexplore.ieee.org/abstract/document/8909142.

## 1. Introduction

The evolution of 5G mobile networks is expected to be comprised of small cell deployments within spitting distance of existing macrocell infrastructures. The small cells adoption, which promises to offer an economical solution for improved coverage and data rate, appears to be the key factor at improving network cooperation and system performance. In this paper, we evaluate the User-Centric model for 5G networks, targeted at improving communication between user terminal and Base Stations across all layers. 

This MATLAB simulation offers a cost-effective, resource-aware method for improved mobile outdoor coverage and overall network capacity while fully respecting the user’s Quality of Service, by decoupling the overall network into downlink and uplink networks. The proposed algorithm determines how the network users in both networks will efficiently connect to a Base Station. The network performances are evaluated in terms of data rates enhancements, association outcome and preservation of the Quality of Service for each user. This low-complexity algorithm ultimately manages to serve the vast majority of the users placed inside an ultra-dense network and achieve perfect preservation of Quality of Service, regardless of the number of active users.

## 2. The Model
The analysis if focused on a geographical area that incorporates an LTE HetNet where equal-size cell division is already assumed. The area includes both small cells, microcells, femtocells and picocells, placed either within the macrocells or to bridge coverage gaps. Each cell contains a BS placed at its center. 

Since the UC model requires different approaches for the decoupled networks, we comply with the Orthogonal Frequency Division Multiple Access (OFDMA) for the downlink architecture and with the Single-Carrier-Frequency Division Multiple Access (SC-FDMA) for the uplink architecture. The available frequency in LTE networks is divided into resource blocks (RBs) and each RB consists of 12 consecutive subcarriers for a fixed duration of 1 ms. SC-FDMA is used in order to achieve higher terminal-related power ratings by supplying the network with augmented peak-to-average power ratio.

![enter image description here](https://i.ibb.co/80kLFV4/RU6-Paper-Scenario.png)

Image 1: A network instance of the UC model scenario

The considered area includes 19 macro cells with an inter-site distance of 375m and 21 small cells with a radius equal to 50m. The area of interest are the 7 macro cells positioned in the center of the ring (colored in Image 2 using darker grey) and the small cells they include. Yet,  an additional ring of BSs is included to take into consideration the interference factor as experienced from macro cell infrastructure outside our area of study. Each macro BS is placed at the center of the cell and each cell includes 3 small cells, all of them placed close to the cell borders. The small cells are placed near the cell borders, since cell-borders users are prone to poor network coverage from the macro cell infrastructure or excessive interference from neighboring cells, issues that can be tackled by the installation of small cells. UEs in the decoupled networks have pre-defined QoS demands that alternate in each simulation, based on the GPP-defined demands. For the area of interest, both decoupled networks are simulated for different numbers of active users.

![enter image description here](https://i.ibb.co/6NsVhh6/untitled0.png)

Image 2: MATLAB scenario for the case of 50 network users

## 3. User Distribution
The proposed mechanism assumes pre-defined context information for the network subscribers and favors UE-BS association through UE’s decision to establish connection with different cells in the uplink and downlink networks. Aiming at maximizing the spectrum efficiency of the UC model while respecting the user data rates, the aforementioned problem transforms into a minimization of required RBs. The proposed low-complexity algorithm requires the following context-aware information: the SINR of the decoupled networks, the system architecture (in our case, this means the uplink and downlink architectures) and the RBs of every available BS in our network. To achieve maximization of spectrum efficiency, we consider as possible BS candidates for the UEs all those who have the lowest RB requirements. As a result, this ensures spectrum efficiency for the UE-BS association problem. Repetitively, each UE will select the best available BS candidate so that its data rate transmission demands are met. Each UE-BS association is possible only if there exist remaining RBs, otherwise, we decide to select the next best candidate. As for any remaining BSs, which are not needed for either the uplink or the downlink network, they are simply discarded.

The association algorithm is formulated and presented below:
![enter image description here](https://i.ibb.co/Syv9Gsh/4.png)

Image 3: The User Distribution Algorithm


## 4. Tools needed

* Project Version : `Final`
* Programming Language : `Matlab`
* Matlab Version : `2019b`


## 5. Project Structure

The project structure is structured as follows:

`initVariables.m`

The function that initialized all variables throughout the simulation (e.g number of devices, resource blocks, station radiation, carrier frequency, bandwidths, subcarriers etc). No variable is hardcoded in the simulation.

`populateGrid.m`

The function that creates the network scenario (see Image 2).

`calculateUplinkThroughputDemands.m`

The function that calculates (based on random probabilities) the throughput needs (or else, the demands in data rates) from the network users in the Uplink decoupled network.

`calculateDownlinkThroughputDemands.m`

The function that calculates (based on random probabilities) the throughput needs (or else, the demands in data rates) from the network users in the Downlink decoupled network.

`calculateUplinkSINR.m`

The function that calculates the SINR between the currently iterated Base Station (macrocell/small cell) and the user device in the Uplink decoupled network.

`calculateDownlinkSINR.m`

The function that calculates the SINR between the user device and the currently iterated Base Station (macrocell/small cell) in the Downlink decoupled network.

`calculateUplinkRBDemands.m`

The function that calculates the Resource Block demands each user creates in the network, based the user's throughput demands (calculated in `calculateUplinkThroughputDemands.m`), the bandwidth of the Resource Block and the SINR between the user and the tested Base Station (macrocell/small cell) (calculated in  `calculateUplinkSINR.m`).

`calculateDownlinkRBDemands.m`

The function that calculates the Resource Block demands each user creates in the network, based the user's throughput demands (calculated in `calculateDownlinkThroughputDemands.m`), the bandwidth of the Resource Block and the SINR between the user and the tested Base Station (macrocell/small cell) (calculated in  `calculateDownlinkSINR.m`).

`associationAlgorithm.m`

The function that begins iterating all network devices both in Downlink and Uplink networks and attemps to find the most optimal connection between the user device and the Base Station.

`ModelSimulation.m`

The main function of the simulation, run this function to begin the simulation.
