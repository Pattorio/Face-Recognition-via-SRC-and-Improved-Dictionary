# Face Recognition via SRC and Improved Dictionary ELEN E6886          
Yimeng Zhou (yz2993)               
Qianwen Zheng (qz2271)

### load_img         
Load images in Extended Yale B database. For each individual, we choose half of images that might span all lighting conditions  as our training set. And we split the rest of images into three set, testset1, testset2, and testset3.

### Load_AR_img                    
Load images in AR databae. For each individual, we choose half of images that might span all face expressions and disguise conditions as our training set, and the rest as testing set.

### inexact_alm_rpca                      
IALM to implement RPCA method.              
Minming Chen, Arvind Ganesh                 
Copyright: Perception and Decision Laboratory, University of Illinois, Urbana-Champaign, Microsoft Research Asia, Beijing           
### inexact_alm_rpca_1             
IALM for RPCA which is written by ourselves

### basis_pursuit                    
ADMM to address l1-norm minimization problem.            
http://www.stanford.edu/~boyd/papers/distr_opt_stat_learning_admm.html

### main       
Main code to implement algorithms.
