package io.swipetivity.core.controller;

import io.swipetivity.core.dto.request.JoinCommunityRequest;
import io.swipetivity.core.dto.request.LeaveCommunityRequest;
import io.swipetivity.core.dto.response.community.CommunityResponse;
import io.swipetivity.core.entity.CommunityEntity;
import io.swipetivity.core.entity.UserEntity;
import io.swipetivity.core.mapper.CommunityMapper;
import io.swipetivity.core.service.CommunityService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/community")
@RequiredArgsConstructor
public class CommunityController {

    private final CommunityService service;
    private final CommunityMapper mapper;

    @GetMapping("/list")
    public List<CommunityResponse> listCommunities(@AuthenticationPrincipal UserEntity user) {
        return service.fetchCommunities(user)
                .stream()
                .map(mapper::toDTO)
                .toList();
    }

    @GetMapping("/{id}")
    public CommunityResponse viewCommunity(@PathVariable long id) {
        CommunityEntity community = service.findCommunityById(id)
                .orElseThrow(() -> new IllegalArgumentException("No community with id %s found.".formatted(id)));

        return mapper.toDTO(community);
    }

    @PostMapping("/join")
    public CommunityResponse joinCommunity(@RequestBody JoinCommunityRequest request, @AuthenticationPrincipal UserEntity user) {
        CommunityEntity community = service.findCommunityByPin(request.getPin())
                .orElseThrow(() -> new IllegalArgumentException("No community with pin %s found.".formatted(request.getPin())));

        service.joinCommunity(community, user);
        return mapper.toDTO(community);
    }

    @PostMapping("/leave")
    public void leaveCommunity(@RequestBody LeaveCommunityRequest request, @AuthenticationPrincipal UserEntity user) {
        CommunityEntity community = service.findCommunityById(request.getId())
                .orElseThrow(() -> new IllegalArgumentException("No community with id %s found.".formatted(request.getId())));

        service.leaveCommunity(community, user);
    }


}