Section Td2.
  Variable A B C: Prop.

  Lemma Premier: A /\(B \/ C) <-> (A /\ B) \/ (A /\ C).
    Proof.
    split.
    intro h0.
    destruct h0.
    destruct H0.
    left.
    split.
    assumption.
    assumption.
    right.
    split.
    assumption.
    assumption.
    intro h.
    destruct h.
    destruct H.
    split.
    assumption.
    left.
    assumption.
    split .
    apply H .
    right.
    apply H.
    Qed.

    Lemma Second : A \/ (B /\ C) <-> (A \/ B) /\ (A \/ C).
    Proof.      
      split.
      intro H.
      split .
      destruct H.
      left.
      assumption.
      destruct H.
      right.
      assumption.
      destruct H.
      left.
      assumption.
      destruct H.
      right.
      assumption.
      intro H.
      destruct H.
      destruct H0.
      left.
      assumption.
      destruct H.
      left.
      assumption.
      right.
      split.
      assumption.
      assumption.
    Qed.


    Section S.
      Hypothesis H: ~A->A.

      Lemma a: ~~A.
      Proof.
        unfold not.
        unfold not in H.
        intro H1.
        apply H1.
        apply H.
        assumption.
      Qed.
End S.
      
    Section S1.
      Hypothesis H: A /\ ~B.

      Lemma neg: ~(A->B).
      Proof.
        unfold not.
        unfold not in H.
        intro H1.
        apply H.
        apply H1.
        destruct H.
        assumption.
      Qed.
      End S1.
End Td2.