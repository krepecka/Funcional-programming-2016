import Test.Hspec
import BoardLogic

main :: IO ()
main = hspec $ do
  describe "BOARD LOGIC" $ do
    describe "checkBoard" $ do
      it "should return FALSE when there's no moves made" $ do
        checkBoard [] 'x' `shouldBe` False
      it "should return TRUE if 'x' won the game" $ do
        checkBoard [(0,0,'x'),(1,1,'x'),(2,2,'x')] 'x' `shouldBe` True

    describe "validate" $ do
      it "should return FALSE if 'x' made all 3 moves" $ do
        validate "ll1:xi0e1:yi0e1:v1:xel1:xi1e1:yi1e1:v1:xel1:xi2e1:yi2e1:v1:xee" `shouldBe` False
      it "should return TRUE if 'x' made 4 moves and 'o' made 3" $ do
        validate ("ll1:xi1e1:yi1e1:v1:xel1:xi0e1:yi2e1:v1:oel1:xi0e1:yi0e1:v1:xel1:xi2e1:" ++
            "yi1e1:v1:oel1:xi2e1:yi0e1:v1:xel1:xi1e1:yi0e1:v1:oel1:xi2e1:yi2e1:v1:xee") `shouldBe` True