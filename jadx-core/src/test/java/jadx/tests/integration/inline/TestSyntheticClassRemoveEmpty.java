package jadx.tests.integration.inline;

import java.util.List;

import org.junit.jupiter.api.Test;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.nodes.ClassNode;
import jadx.tests.api.SmaliTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

public class TestSyntheticClassRemoveEmpty extends SmaliTest {

	@Test
	public void test() {
		List<ClassNode> classes = loadFromSmaliFiles();
		assertThat(searchCls(classes, "inline.TestSyntheticClassRemoveEmpty.Caller"))
				.code()
				.containsOne("return sb.length() >= 5;");

		ClassNode trampoline = searchCls(classes, "inline.TestSyntheticClassRemoveEmpty.Trampoline");
		assertThat(trampoline.getCode().getCodeStr())
				.describedAs("Inlined trampoline class must not be generated")
				.isEmpty();
		assertThat(trampoline.contains(AFlag.DONT_GENERATE)).isTrue();
	}
}
