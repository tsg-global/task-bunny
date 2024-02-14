defmodule TaskBunny.FailureBackend.Logger do
  @moduledoc """
  Default failure backend that reports job errors to Logger.
  """
  use TaskBunny.FailureBackend
  require Logger
  alias TaskBunny.JobError

  # Callback for FailureBackend
  def report_job_error(error = %JobError{}) do
    error
    |> get_job_error_message()
    |> do_report(error.reject)
  end

  @doc """
  Returns the message content for the job error.
  """
  @spec get_job_error_message(JobError.t()) :: String.t()
  def get_job_error_message(error = %JobError{error_type: :exception}) do
    message = "TaskBunny - #{error.job} failed for an exception."

    meta = [
      exception: inspect(error.exception),
      stacktrace: Exception.format_stacktrace(error.stacktrace)
    ]

    {message, meta}
  end

  def get_job_error_message(error = %JobError{error_type: :return_value}) do
    message = "TaskBunny - #{error.job} failed for an invalid return value."

    {message, error}
  end

  def get_job_error_message(error = %JobError{error_type: :exit}) do
    message = "TaskBunny - #{error.job} failed for EXIT signal."

    {message, error}
  end

  def get_job_error_message(error = %JobError{error_type: :timeout}) do
    message = "TaskBunny - #{error.job} failed for timeout."

    {message, error}
  end

  def get_job_error_message(error = %JobError{}) do
    message = "TaskBunny - Failed with the unknown error type."

    {message, error}
  end

  defp do_report({message, metadata}, rejected) do
    if rejected do
      Logger.error(message, metadata: metadata)
    else
      Logger.warning(message, metadata: metadata)
    end
  end
end
