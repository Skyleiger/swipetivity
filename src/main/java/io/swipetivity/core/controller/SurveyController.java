package io.swipetivity.core.controller;

import io.swipetivity.core.dto.response.survey.SurveyResponse;
import io.swipetivity.core.entity.SurveyEntity;
import io.swipetivity.core.entity.UserEntity;
import io.swipetivity.core.mapper.SurveyMapper;
import io.swipetivity.core.service.SurveyService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/survey")
@RequiredArgsConstructor
public class SurveyController {

    private final SurveyService service;
    private final SurveyMapper mapper;

    @GetMapping("/list")
    public List<SurveyResponse> listSurveys(@AuthenticationPrincipal UserEntity user) {
        return service.fetchSurveys(user)
                .stream()
                .map(mapper::toDTO)
                .toList();
    }

    @GetMapping("/{id}")
    public SurveyResponse viewSurvey(@PathVariable long id) {
        SurveyEntity survey = service.findSurveyById(id)
                .orElseThrow(() -> new IllegalArgumentException("No survey with id %s found.".formatted(id)));

        return mapper.toDTO(survey);
    }

    @PostMapping("/create")
    public SurveyResponse createSurvey(@RequestBody SurveyResponse request, @AuthenticationPrincipal UserEntity user) {
        SurveyEntity survey = service.createSurvey(request.getCommunity(), request.getName(), request.getDescription());
        return mapper.toDTO(survey);
    }

}