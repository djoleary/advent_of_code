(** Day 3 Part 1
   Implementation Plan:

   For each line:
   1. Start with the tuple [(None, None)]
   2. Put the first two digits in the sequence into the tuple => [(Some m, Some n)]
   3. Walk the sequence
     - IF the digit in the sequence is greater than the first element of the tuple
       AND we are not looking at the last digit in the sequence,
         replace the first element of the tuple with that digit and set the other digit to None.
     - IF the digit in the sequence did not replace the first element of the tuple
       AND the digit is greater than the second element of the tuple,
        replace the second element of the tuple with that digit.
   4. Concat the elements of the tuple "string-wise" => [(Some m', Some n')] => [m' ^ n']
   5. Cast to int

   Sum the result of each line
 *)

let solve _ () = failwith "not started"
