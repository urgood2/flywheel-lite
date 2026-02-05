# Plan Quality Checklist

A complete implementation plan MUST contain ALL of these sections:

## 1. Executive Summary
- Problem statement (what pain point are we solving?)
- Solution overview (TL;DR of the approach)
- Key innovations table (what's novel about this approach?)

## 2. Core Architecture
- System diagram (ASCII or description of components)
- Design principles (3-7 guiding principles)
- Data flow overview

## 3. Data Models
- TypeScript/Zod schemas OR equivalent type definitions
- Validation rules for each entity
- Relationships between entities

## 4. CLI/API Surface
- Every command/endpoint with usage examples
- Input/output formats (JSON examples)
- Error responses

## 5. Error Handling & Edge Cases
- What can go wrong?
- Recovery strategies
- Failure modes and mitigations

## 6. Integration Points
- External dependencies
- Secret/credential handling
- Configuration management

## 7. Storage & Persistence
- Directory structure
- File formats
- Caching strategy (if applicable)

## 8. Implementation Roadmap
- Phased delivery (Phase 1, 2, 3...)
- Dependencies between phases
- Estimated complexity per task (S/M/L)
- Parallelization opportunities

## 9. Testing Strategy
- Unit test approach
- Integration/E2E test approach
- Test data requirements

## 10. Comparison & Trade-offs
- Why this approach over alternatives?
- Trade-offs acknowledged
- Future considerations

## Quality Criteria

A plan is IMPLEMENTATION-READY when:
- [ ] Every section above is present and detailed
- [ ] File paths and function names are specific (not somewhere in src/)
- [ ] Data schemas are concrete (actual field names and types)
- [ ] Commands have actual usage examples
- [ ] Edge cases are anticipated, not hand-waved
- [ ] Tasks can be executed by an agent without asking clarifying questions
