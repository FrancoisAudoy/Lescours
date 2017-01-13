
Section LJ.
 Variables P Q R S T : Prop.

(* Prouver les jugements de l'exercice 7 de la feuille de TD sur la
   logique propositionnelle *)
 Lemma Abbbb : P\/(Q\/R) <-> P\/Q\/R .
 Proof.
   split.
   intro H.
   assumption.
   intro H.
   assumption.
 Qed.

 Lemma B : P/\(Q\/R) <-> P/\Q \/ P/\R .
 Proof.
   split.
   intro H.
   destruct H.
   destruct H0.
   left. 
   split.
   assumption. 
   assumption.
   right.
   split .
   assumption.
   assumption.
   intro H.
   destruct H.
   destruct H.
   split.
   assumption.
   left.
   assumption.
   destruct H.
   split.
   assumption.
   right.
   assumption.
   Qed.
End LJ.

Definition EXM :=   forall A:Prop, A \/ ~A.

  Ltac add_exm  A :=
    let hname := fresh "exm" in
    assert(hname : A \/ ~A);auto.


Section LK.


  Hypothesis  exm :  EXM.
   Variables P Q R S T : Prop.



  Lemma double_neg : ~~ P -> P.
  Proof.
    intro H.
    add_exm  P.
    destruct exm0.
    unfold not in H.
    assumption.
    assert (f:False).
    apply H.
    assumption.
    destruct f.
    Qed.
    
  Lemma de_morgan : ~ (~ P /\ ~ Q) <-> P \/ Q.
  Proof.
  unfold not.
  split.
  intro H.
  add_exm P.
  destruct exm0.
  left.
  assumption.
  add_exm Q.
  destruct exm0.
  right.
  assumption.
  destruct H.
  split.
  assumption.
  assumption.
  intro H.
  destruct H.
  intro H1.
  destruct H1.
  apply H0.
  assumption.
  intro H1.
  destruct H1.
  apply H1.
  assumption.
  Qed.

 Lemma not_impl_or : ~(P -> Q) <-> P /\ ~ Q.
 Proof.
   unfold not.
   split.
   split.
   add_exm P.
   destruct exm0.
   assumption.
   assert(f:False).
   apply H.
   intro H1.
   assert(f:False).
   apply H0.
   assumption.
   destruct f.
   destruct f.
   intro H1.
   apply H.
   intro H2.
   assumption.
   intro H.
   destruct H.
   intro H2.
   apply H0.
   apply H2.
   assumption.
   Qed.

 Lemma exm_e : (P -> Q) -> (~P -> Q) -> Q.
  Proof.
    intro H.
    intro H2.
    add_exm P.
    destruct exm0.
    apply H.
    assumption.
    apply H2.
    assumption.
  Qed.
    

  Lemma exo_18 : (~ P -> P) -> P.
  Proof.
    unfold not.
    intro H.
    add_exm P.
    destruct exm0.
    assumption.
    apply H.
    assumption.
Qed.

    
  Lemma exo19 : (P -> Q) \/ (Q -> P).
  Proof.
    add_exm Q.
    destruct exm0.
    left.
    intro H2.
    assumption.
    right.
    intro H1.
    assert(f:False).
    apply H.
    assumption.
    destruct f.
  Qed.



    Lemma imp_translation : (P -> Q) <-> ~P \/ Q.
  Proof.
  split.
  intro H.
  add_exm P.
  destruct exm0.
  right.
  apply H.
  assumption.
  left.
  assumption.
  intro H.
  intro H1.
  destruct H.
  assert(f:False).
  apply H.
  assumption.
  destruct f.
  assumption.
  Qed.





  Lemma Peirce : (( P -> Q) -> P) -> P.
  Proof.
    add_exm P.
    destruct exm0.
    intro. 
    assumption.
    intro.
    apply H0.
    intro.
    assert(f:False).
    apply H.
    assumption.
    destruct f.
    Qed.
    
End LK.

About double_neg.

Section Second_ordre.
Definition PEIRCE := forall A B:Prop, ((A -> B) -> A) -> A.
Definition DNEG := forall A, ~~A <-> A.
Definition IMP2OR := forall A B:Prop, (A->B) <-> ~A \/ B.

Lemma L1 : IMP2OR -> EXM.
unfold IMP2OR, EXM.
intros.
 assert (~A \/ A).
 apply H. (* nouveau *)
 intro .
 assumption.
 destruct H0.
 right.
 assumption. 
 left.
 assumption.
Qed.

Lemma L2 : EXM -> DNEG.
  unfold DNEG , EXM.
  intros.
  add_exm A.
  destruct exm.
  split.
  intro.
  assumption.
  intro.
  intro.
  apply H2.
  assumption.
  split.
  intro.
  assert(f:False).
  apply H1.
  assumption.
  destruct f.
  intro .
  intro.
  apply H0.
  assumption.
Qed.

Lemma L3 : PEIRCE -> DNEG.
unfold DNEG , PEIRCE.
intros.
split.
intro. apply (H A False).
intro.
contradiction.
intro.
intro.
apply H1.
assumption.
Qed.


Lemma L4 : EXM -> PEIRCE.
Proof. (*
exact Peirce.
Qed.
       *)
  unfold EXM,PEIRCE.
  
intros.
add_exm A.
destruct exm.
assumption.
apply H0.
intro .
assert(f:False).
apply H1.
assumption.
destruct f.
Qed.
End Second_ordre.

(* tactiques nouvelles 
*)
  