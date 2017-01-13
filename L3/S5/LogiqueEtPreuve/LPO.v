(* Logique du premier ordre *)

(** Tactiques :
  pour forall :   intro, intros.
                  apply, eapply, specialize.
                  (H x ...)

  pour exists     exists, destruct.

  pour =          reflexivity,
                  rewrite H   [in HØ]
                  rewrite <- H [in H0]
                  
 *)



Definition EXM :=   forall P:Prop, P \/ ~P.

Ltac add_exm  P :=
  let hname := fresh "exm" in
  assert(hname : P \/ ~P);auto.

Theorem Kabsurd : EXM -> forall P:Prop,  (~ P -> False) -> P.
Proof.
  unfold EXM.
  unfold not.
  intros H P H0.
  add_exm P.
  apply H.
  destruct exm.
  assumption.
  contradiction.
Qed.

Ltac Kabsurd := apply Kabsurd; auto. 

Section Declarations.
  Variables A B C: Type.

  Variables P Q : A -> Prop.
  Variables R S : A -> A -> Prop.

  Variable f : A -> B.
  Variable g : B -> C.

  Lemma diff_sym : forall x y:A, x <> y -> y <> x.
  Proof.
    intros x y H H0; rewrite H0 in H.
    now destruct H.
 Qed.

  Lemma L1 : forall x:A, P x -> exists y:A, P y.
    intro; intro.
    exists x.
    apply H.
    Qed.
  Lemma L01 : forall x:A, exists y:A, x = y.
    intro.
    exists x.
    trivial.
    Qed.
  Lemma L001 : forall a:A, exists b:B, b = b.  
    intro.
    exists (f a) .
    trivial.
    Qed.
    
  

  Lemma L02 : (exists x: A, ~ P x) -> ~ forall x, P x.
    intro .
    intro .
    destruct H.
    apply H.
    apply H0.
    Qed.
    

  Lemma L03 : ~ (exists x, P x) -> forall x, ~ P x.
    unfold not .
    intro; intro.
    intro .
    apply H.
    exists x.
    apply H0.
    Qed.
  Lemma L2 : EXM -> ~(forall x, P x) -> exists x, ~ P x. (* ** *)
    unfold EXM.
    unfold not.
    intros.
    add_exm (forall x, P x) .
    destruct exm.
    Admitted.
    
  Definition reflexive (R: A -> A -> Prop) := forall x, R x x.
  Definition transitive R :=  forall x y z: A, R x y -> R y z -> R x z.
  Definition symmetric R := forall x y:A, R x y -> R y x.
  Definition antisymmetric R := forall x y : A, R x y -> R y x -> x = y.
  Definition irreflexive R := forall x : A, ~ R x x.
  Section order.
    Variable lt : A -> A -> Prop.
    Infix "<" := lt.
    Definition le (x y : A) := x < y \/ x = y.
    Infix "<=" := le.
    Definition minorant X m := forall x, X x -> m <= x.
    Definition majorant X M := forall x, X x -> x <= M.
    Definition minimal X m := X m /\ forall x, X x -> x <= m -> x = m.
    Definition maximal X M := X M /\ forall x, X x -> M <= x -> x = M.
    
    Hypothesis lt_irreflexive : irreflexive lt.
    Hypothesis lt_trans : transitive lt.

    Lemma le_refl : reflexive le.
    Proof.
      (* unfold le, reflexive *) intro x.
                                 right.
                                 trivial.
    Qed.

    Lemma le_antisym : antisymmetric le.
    Proof.
      intros x y H H0.
      destruct H, H0.
      absurd (x < x).
      auto.
      now apply lt_trans with y.
      rewrite H0 in H; auto.
      absurd (x < x); auto.
      rewrite <- H in H0; auto.
      trivial.
    Qed.               


    Lemma le_trans : transitive le.
      unfold le.
      unfold transitive .
      unfold transitive in lt_trans.
      unfold irreflexive in lt_irreflexive .
      intros .
      destruct H; destruct H0.
      specialize lt_trans with x y z .
      left .
      apply lt_trans .
      assumption.
      assumption.
      left.
      rewrite H0 in H.
      assumption.
      left .
      rewrite H .
      apply H0.
      right .
      rewrite H.
      assumption .
      Qed.

    Definition minimal_alt X m := X m /\ forall x, x < m -> ~ X x.
    Lemma minimal_alt_ok : forall X m, minimal X m <-> minimal_alt X m. 
      unfold minimal; unfold minimal_alt.
      unfold transitive in lt_trans.
      unfold irreflexive in lt_irreflexive .
      intros.
      split .
      intro .
      split .
      apply H.
      intros .
      intro .
      destruct H.
      specialize H2 with x  .
      assert (x=m).
      apply H2.
      assumption.
      left .
      assumption .
      specialize lt_irreflexive with m.
      apply lt_irreflexive .
      rewrite H3 in H0.
      assumption.
      intros .
      split .
      destruct H.
      assumption .
      destruct H .
      intros .
      destruct H2.
      specialize H0 with x .
      assert( F: False ).
      apply H0.
      assumption .
      assumption .
      contradiction .
      assumption .
      Qed.
  End order.
End Declarations.


Section drinkers_problem.
  Variable people : Type.
  Variable patron : people.
  Hypothesis classic : EXM.
  Variable boit : people -> Prop.
  Theorem buveurs :
    exists p:people, boit p -> forall q, boit q.
  Proof.
    add_exm (forall q, boit q).
    destruct exm.
    - exists patron;auto.
    -  About L2.
       destruct (L2 _ boit classic).
       auto.
       exists x; intro; contradiction.
  Qed.

End drinkers_problem.


Section Peano.
  Variable Nat : Set.
  Variable zero : Nat.
  Variable succ : Nat -> Nat.
  Variable plus : Nat -> Nat -> Nat.
  Infix "+" := plus.
  Notation "0" := zero. 
  
  Hypothesis succ_inj : forall x y, succ x = succ y -> x = y.
  Hypothesis succ_diff : forall x,  succ x <> 0.
  Hypothesis Nat_ind : forall P : Nat-> Prop,
                         P 0 ->
                         (forall n, P n -> P (succ n)) ->
                         forall n : Nat, P n.

  Ltac recurrence n := let Hrec := fresh "Hrec" in
                       let var_n := fresh "n" in
                       pattern n; apply Nat_ind;[ | intros var_n Hrec; intros].

  Hypothesis plus_def1 : forall x, 0 + x = x.
  Hypothesis plus_def2 : forall x y, (succ x) + y = succ (x + y).

  
  Lemma plus_n_0 : forall n:Nat, n + 0 = n.
  Proof.
    intro n; recurrence n.
    - now rewrite plus_def1.
    - rewrite plus_def2.
      now rewrite Hrec.
  Qed.

  Lemma plus_n_succ : forall n p, n + succ p = succ (n + p).
  Proof.
    intro n; recurrence n.
    - intro; repeat rewrite plus_def1; auto.
    - repeat rewrite plus_def2.
      now rewrite Hrec.
  Qed.

  Lemma plus_comm : forall n p, n + p = p + n.
  Proof.
    intro n; recurrence n.
  Admitted.



  Lemma plus_assoc : forall n p q, n + p + q = n + ( p + q).
    intro n; recurrence n.
    - intros p q; now repeat rewrite plus_def1.
    - repeat rewrite plus_def2.
      now rewrite (Hrec p q).
  Qed.
  
  Lemma plus_eq_0 : forall x y, x + y = 0 -> x = 0 /\  y = 0.
  Proof.
  Admitted.

End Peano.


Section non_standard_Peano.
  Definition D := (nat * bool)%type.
  Definition zero := (0,false).
  Definition succ (d:D) := (1+ fst d, snd d).

  Lemma succ_inj' : forall d d':D, succ d = succ d' -> d = d'.
  Proof.
    intros d d'; destruct d, d'.
    unfold succ;simpl.
    injection 1; intros; subst; auto.
  Qed.

  Lemma succ_diff' : forall d:D , succ d <> zero.
  Proof.
    destruct d.
    unfold succ;simpl.
    discriminate.
  Qed.

  Section non_induction.
    Let P := fun d : D => snd d = false.

    Lemma base_case : P zero.
      now red;simpl.
    Qed.

    Lemma induc_case : forall n:D, P n -> P (succ n).
    Proof.
      intros n; unfold P; destruct n;simpl.
      auto.
    Qed.

    Lemma not_concl : ~ forall n:D, P n.
    Proof.
      intro H.
      specialize (H (0,true)).
      red in H.
      discriminate.
    Qed.

  End non_induction.

  Theorem non_induction :
    ~ (forall P : D -> Prop,
         P zero ->
         (forall n, P n -> P (succ n)) ->
         forall n : D, P n).
  Proof.
    intro H.
    About not_concl.
    specialize (H (fun d : D => snd d = false) base_case induc_case).
    apply not_concl. apply H.
  Qed.

End non_standard_Peano.

