# Contributing to ASO Skills

Thanks for your interest in contributing! ASO Skills is a collection of expert-level playbooks that teach AI agents how to do App Store Optimization.

## How to contribute

### Adding a new skill

1. Create a directory under `skills/` with a kebab-case name
2. Add a `SKILL.md` file with YAML frontmatter:

```yaml
---
name: your-skill-name
description: One-line trigger description — when should this skill activate?
---
```

3. Follow the structure of existing skills:
   - Start with **Iron Law** (the one rule that must never be broken)
   - Include a **Socratic intake** section (questions to ask before acting)
   - Reference `quality-gates/*.md` where applicable
   - Use `aso` CLI commands for data gathering
   - End with actionable output the user can apply

### Adding a quality gate

1. Create a markdown file in `quality-gates/`
2. Include: Rule, Why, How to check, Exceptions, Fix
3. Reference it from relevant skills using `**REQUIRED:** quality-gates/your-gate.md`

### Guidelines

- Skills should be opinionated and expert-level, not generic
- Include real-world reasoning — explain *why*, not just *what*
- Prefer concrete examples over abstract instructions
- Quality gates should be binary (pass/fail), not subjective
- Test your skill by having an AI agent follow it end-to-end

## Code of conduct

Be helpful, be specific, be kind. We're building tools that help indie developers succeed.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
