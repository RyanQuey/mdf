% define function to start mdf v1.6
function startMdf() 

  % add correct path
  addpath('$MDF_CONF_PATH/mMDF/core');

  global omdfc;
  omdfc = mdf.init(struct('confFile','$MDF_CONF_PATH/conf/mdf.conf.xml'));

end
