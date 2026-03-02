package jadx.tests.integration.switches;

import org.junit.jupiter.api.Test;

import jadx.tests.api.SmaliTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

/**
 * R8/D8 pattern: switch-over-string with code inlined directly in hashCode cases,
 * no second index-based switch.
 */
public class TestSwitchOverStrings5 extends SmaliTest {

	@Test
	public void test() {
		noDebugInfo();
		assertThat(getClassNodeFromSmali())
				.code()
				.doesNotContain("hashCode")
				.doesNotContain("equals")
				.containsOne("switch (");
	}
}
