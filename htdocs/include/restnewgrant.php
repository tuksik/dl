<?php
// REST "newgrant" request
require_once("grantfuncs.php");

function newgrant($msg, $params = null)
{
  global $grantRestParams;

  // handle the request
  $DATA = false;
  if($validated = validateParams($grantRestParams, $msg))
    $DATA = handleGrant($msg);

  if($DATA === false)
  {
    // grant creation unsucessfull
    if($validated)
    {
      logReq('invalid grant parameters', LOG_ERR);
      return array('httpInternalError', 'internal error');
    }
    else
    {
      // errors already generated in handleGrant
      return array('httpBadRequest', 'bad parameters');
    }
  }

  // return grant instance
  return array(false, array
  (
    "id"  => $DATA['id'],
    "url" => grantUrl($DATA),
  ));
}

?>
