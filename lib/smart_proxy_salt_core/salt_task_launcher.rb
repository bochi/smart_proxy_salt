module SmartProxySaltCore
  # Implements the TaskLauncher::Batch for Salt
  class SaltTaskLauncher < ForemanTasksCore::TaskLauncher::Batch
    # Implements the Runner::Action for Salt
    class SaltRunnerAction < ForemanTasksCore::Runner::Action
      def initiate_runner
        additional_options = {
          :step_id => run_step_id,
          :uuid => execution_plan_id
        }
        ::SmartProxySaltCore::SaltRunner.new(
          input.merge(additional_options),
          :suspended_action => suspended_action
        )
      end
    end

    def child_launcher(parent)
      ForemanTasksCore::TaskLauncher::Single.new(world, callback, :parent => parent,
                                                                  :action_class_override => SaltRunnerAction)
    end
  end
end
