package org.example.repository;

import org.example.model.Reserva;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReservaRepository extends JpaRepository<Reserva, Integer> {

    List<Reserva> findByLivroIdOrderByDataReserva(Integer livroId);

}