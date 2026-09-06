{ pkgs }:

let
  mod = name: url: sha512: {
    name = "mods/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };
in
[
  (mod "Spark" 
    "https://cdn.modrinth.com/data/l6YH9Als/versions/DdMsOH3O/spark-1.10.173-neoforge.jar" 
    "f40b72761c2137debe90c836a32918e4e3aa2629db4b50e9b78bdcacdbe6e484682ba7e11535bee7fcf581abe944948dde48dda37ee45d3966a5d7e450191173")

  (mod "Terralith" 
    "https://cdn.modrinth.com/data/8oi3bsk5/versions/lqrGyTjO/Terralith_26.2_v2.6.4_Neoforge.jar" 
    "b66ade8d34cb61af8174eac4af9905d741a456fdd4c32f1674d106a47094ae560cd9652cf4904ebff591c931134dc3d307fbfa0904503d202e1048289b6f8d3b")

  (mod "lithostitched" 
    "https://cdn.modrinth.com/data/XaDC71GB/versions/uJERiR1V/lithostitched-1.8.0%2Bbeta3-neoforge-26.2.jar" 
    "9a8b6b38c58076d601c25b03eeb3f398385467ffd5029ebc7b6f403289ad150fd4a0b550de0bd3bfa0af49f308c2eb633743677630821c10849318b42e7dd229")

  (mod "Nullscape" 
    "https://cdn.modrinth.com/data/LPjGiSO4/versions/lpsdO6Sg/Nullscape_26.2_v1.2.20.jar" 
    "8c8f5ec050fb038da653c1023d2bbaf01cf0a88354d8081dbf99513375a64ebc18c669650d017c938ab4c4314c47f8b706422d8df43f4652c6c85460a63b6f01")

  (mod "Incendium" 
    "https://cdn.modrinth.com/data/ZVzW5oNS/versions/vPwuqZ5y/Incendium_26.2_v5.5.1.jar" 
    "202e1f23c64c37330d3ec0bfd80331355d15cc8d01f151edc4dabfa8ce719650d10f468df5bf523a93461d78c3660a2cdedbc1037fb08396c13f22b6457352f0")

  (mod "Tectonic" 
    "https://cdn.modrinth.com/data/lWDHr9jE/versions/E17asqTn/tectonic-3.0.27-neoforge-26.2.jar" 
    "5a275fe0c89a84e63307d3bde9296af509b4708ae71e1a9f15daec0223968c0fb7ebba933b6f3068da1d2fefb02f07e879e355367ace494f25b7b7967873d756")

]