variables that throw a nan
---
loc in forces // stops being able to get the position of a particle when they all dissappear
d = dir.mag(); //always positive
dir / possibly negative
force // eventually throws nan b/c division by d^2
force in apply force
acc apply force
vel update
acc update
loc update
final acc update

--

dir
force applyforce
acc applyforce
vel update
acc update
loc update
final acc update

--

order of throws
forces
apply force
update

doesn't reach run

--

no nans
--
tx
ty
targetloc

possible causes
--
time of block?
multiple stimulus
different instances order of nan