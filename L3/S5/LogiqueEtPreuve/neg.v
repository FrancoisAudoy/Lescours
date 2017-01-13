Section Peirce_double_neg.
  Variables P Q S: Prop.

  (* Executez cette preuve en essayant de comprendre le sens de chacune des nouvelles tactiques utilisées. *)
  Lemma absurde_exemple: P -> ~P -> S.
    intros p np.
    unfold not in np.
    assert(F: False).
    apply np; assumption.
    destruct F.
  Qed.
  
    (* Réalisez les preuves suivantes. *)
  Lemma absurde: (P -> Q) -> (P -> ~Q) -> (P -> S).
    intro h.
    intro h1.
    intro h2.
    assert(f:False).
    apply h1.
    assumption.
    apply h.
    assumption.
    destruct f.
  Qed.

  Lemma triple_abs: ~P -> ~~~P.
    unfold not.
    intro h.
    intro h1.
    apply h1.
    assumption.
  Qed. 
  
  Lemma equiv1 : (~P -> P) <-> ~~P.
    unfold not.
    split.
    intro h.
    intro h1.
    apply h1.
    apply h.
    assumption.
    intro h.
    intro h1.
    assert(f:False).
    apply h.
    assumption.
    destruct f.
  Qed.


End Peirce_double_neg.

Section complique.
Variables P Q A B: Prop.
Lemma complique_1: ~(P\/Q) <-> (~P/\~Q).
  unfold not.
  split.
  intro h.
  split.
  intro h1.
  apply h.
  left.
  assumption.
  intro h2.
  apply h.
  right.
  assumption.
  intro h.
  intro h1.
  destruct h.
  destruct h1.
  apply H.
  assumption.
  apply H0.
  assumption.
Qed.
