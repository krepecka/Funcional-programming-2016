{-# LANGUAGE OverloadedStrings #-}
module Protocol(postMoves, getMoves) where

import Network.HTTP.Conduit
import Network.HTTP.Types
import Data.Functor
import qualified Data.ByteString.Lazy as L
import Data.Char (chr)
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy.Char8 as C

import GameConfiguration
import Parsing
import Types

postMoves :: Moves -> IO ()
postMoves moves = do
    req <- buildPostRequest movesStr
    void $ sendRequest $ req
    where movesStr = movesToStr moves

getMoves :: IO Moves
getMoves = do
    req <- buildGetRequest 
    print "Getting"
    let resStr = fmap C.unpack $ sendRequest req
    fmap (strToMoves) resStr


buildGetRequest :: IO Request
buildGetRequest = do
  req <- parseUrlThrow url
  return(req { method = methodGet
                 , requestHeaders = [( "Accept", "application/bencode+list")]
                 })
                 
buildPostRequest :: String -> IO Request
buildPostRequest m = do
  req <- parseUrlThrow url 
  return ( req { method = methodPost
                 , requestHeaders = [("Content-Type", "application/bencode+list")]
                 , requestBody = RequestBodyLBS $ C.pack m--"ll1:xi0e1:yi2e1:v1:xee"
  })
 
sendRequest :: Request -> IO C.ByteString
sendRequest a = do
  manager <- newManager tlsManagerSettings
  res <- httpLbs a manager
  return (responseBody res)
 
